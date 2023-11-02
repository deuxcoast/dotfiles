import json
import os.path
import re
import urllib.parse

import requests
from anki.hooks import addHook
from bs4 import BeautifulSoup


def escape_html_chars(s):
    html_escape_table = {
        "&": "&amp;",
        '"': "&quot;",
        "'": "&apos;",
        ">": "&gt;",
        "<": "&lt;",
        # "\n":"<br>"
        "<br>": "\n",
        "&nbsp;": " ",
    }

    result = "".join(html_escape_table.get(c, c) for c in s)

    return result


def wrap_in_tags(editor, tag1, tag2, class_name=None):
    """
    Wrap selected text in a tag, optionally giving it a class.
    """
    selection = editor.web.selectedText()

    if not selection:
        return

    selection = escape_html_chars(selection)
    # print("before1:",repr(selection))
    # selection = selection.replace("\n", "<br>")
    # print("after1:", repr(selection))

    tag_string_begin = (
        "<{0}><{1} class='language-{2}'>".format(tag1, tag2, class_name)
        if class_name
        else "<{0}><{1}>".format(tag1, tag2)
    )
    tag_string_end = "</{0}></{1}>".format(tag1, tag2)

    html = editor.note.fields[editor.currentField]

    if "<li><br /></li>" in html:
        # an empty list means trouble, because somehow Anki will also make the
        # line in which we want to put a <code> tag a list if we continue
        replacement = tag_string_begin + selection + tag_string_end
        editor.web.eval(
            "document.execCommand('insertHTML', false, %s);" % json.dumps(replacement)
        )

        editor.web.setFocus()
        field = editor.currentField
        editor.web.eval("focusField(%d);" % field)

        def cb():
            html_after = editor.note.fields[field]

            if html_after != html:
                # you're in luck!
                return
            else:
                # nothing happened :( this is a quirk that has to do with <code> tags following <div> tags
                return

        editor.saveNow(cb)

    # Due to a bug in Anki or BeautifulSoup, we cannot use a simple
    # wrap operation like with <a>. So this is a very hackish way of making
    # sure that a <code> tag may precede or follow a <div> and that the tag
    # won't eat the character immediately preceding or following it
    pattern = "@%*!"
    len_p = len(pattern)

    # first, wrap the selection up in a pattern that the user is unlikely
    # to use in its own cards
    editor.web.eval("wrap('{0}', '{1}')".format(pattern, pattern[::-1]))

    # focus the field, so that changes are saved
    # this causes the cursor to go to the end of the field
    editor.web.setFocus()
    field = editor.currentField
    editor.web.eval("focusField(%d);" % field)

    # print("selection:", repr(selection))
    # if tag == "blockquote":
    #     selection = selection.replace("\n", "<br>")

    def cb1():
        html = editor.note.fields[field]
        begin = html.find(pattern)
        end = html.find(pattern[::-1], begin)

        # print("before:", html)
        # 原来有<pre>标签，就把它替换成有class的，即添加<pre>标签时即使重复点两次也没事
        if re.match("<pre[^<]+?@%\*!", html):
            html = re.sub("<pre[^<]+?@%\*!", "<pre class='myCodeClass'>@%*!", html)
            html = html.replace("!*%@<br>", "!*%@")
            # print("before:",html)
            html = html.replace(pattern, "")
            html = html.replace(pattern[::-1], "")
            # print("after:", html)
        else:
            html = html.replace("!*%@<br>", "!*%@")
            html = (
                html[:begin]
                + tag_string_begin
                + selection
                + tag_string_end
                + html[end + len_p :]
            )
        # print("after:",html)
        # if tag == "blockquote":
        #     html.replace()
        # delete the current HTML and replace it by our new & improved one
        editor.note.fields[field] = html

        # reload the note: this is needed on OS X, because it will otherwise
        # falsely show that the formatting of the element at the start of
        # the HTML has spread across the entire note
        editor.loadNote()

        # focus the field, so that changes are saved
        editor.web.setFocus()
        editor.web.eval("focusField(%d);" % field)

    editor.saveNow(cb1)

    def cb2():
        editor.web.setFocus()
        editor.web.eval("focusField(%d);" % field)

    editor.saveNow(cb2)


def delete_tag(editor, pre_fix, post_fix):
    selection = editor.web.selectedText()

    if not selection:
        return

    selection = escape_html_chars(selection)
    pattern = "@%*!"

    html = editor.note.fields[editor.currentField]

    if "<li><br /></li>" in html:
        # an empty list means trouble, because somehow Anki will also make the
        # line in which we want to put a <code> tag a list if we continue
        replacement = pattern + selection + pattern[::-1]
        editor.web.eval(
            "document.execCommand('insertHTML', false, %s);" % json.dumps(replacement)
        )

        editor.web.setFocus()
        field = editor.currentField
        editor.web.eval("focusField(%d);" % field)

        def cb():
            html_after = editor.note.fields[field]

            if html_after != html:
                # you're in luck!
                return
            else:
                # nothing happened :( this is a quirk that has to do with <code> tags following <div> tags
                return

        editor.saveNow(cb)

    editor.web.eval("wrap('{0}', '{1}')".format(pattern, pattern[::-1]))

    # focus the field, so that changes are saved
    # this causes the cursor to go to the end of the field
    editor.web.setFocus()
    field = editor.currentField
    editor.web.eval("focusField(%d);" % field)

    def cb1():
        html = editor.note.fields[field]
        # print("before:",html)
        # print("first:",f'{pre_fix}{re.escape(pattern)}')
        # print("second:",f'{re.escape(pattern[::-1])}{post_fix}')

        # print("delete_before:",html)

        # 删除pattern[::-1]后面的<br>
        html = re.sub(f"(?<={re.escape(pattern[::-1])})(<br>)+", "", html)
        # print("process1:", html)
        # print("regex-pre:",f'{pre_fix}{re.escape(pattern)}')
        html = re.sub(f"{pre_fix}{re.escape(pattern)}", "", html)
        # print("process2:", html)
        # print("regex-post:", f'{re.escape(pattern[::-1])}\s?{post_fix}')
        # \s是有时候有换行
        html = re.sub(f"{re.escape(pattern[::-1])}\s?{post_fix}", "", html)

        # print("delete_after:", html)
        # delete the current HTML and replace it by our new & improved one
        editor.note.fields[field] = html

        # reload the note: this is needed on OS X, because it will otherwise
        # falsely show that the formatting of the element at the start of
        # the HTML has spread across the entire note
        editor.loadNote()

        # focus the field, so that changes are saved
        editor.web.setFocus()
        editor.web.eval("focusField(%d);" % field)

    editor.saveNow(cb1)

    def cb2():
        editor.web.setFocus()
        editor.web.eval("focusField(%d);" % field)

    editor.saveNow(cb2)


def wrap_ping(editor):
    selection = editor.web.selectedText()

    if not selection:
        return

    selection = escape_html_chars(selection)
    pattern = "@%*!"

    html = editor.note.fields[editor.currentField]

    if "<li><br /></li>" in html:
        replacement = pattern + selection + pattern[::-1]
        editor.web.eval(
            "document.execCommand('insertHTML', false, %s);" % json.dumps(replacement)
        )

        editor.web.setFocus()
        field = editor.currentField
        editor.web.eval("focusField(%d);" % field)

        def cb():
            html_after = editor.note.fields[field]

            if html_after != html:
                # you're in luck!
                return
            else:
                return

        editor.saveNow(cb)

    editor.web.eval("wrap('{0}', '{1}')".format(pattern, pattern[::-1]))

    editor.web.setFocus()
    field = editor.currentField
    editor.web.eval("focusField(%d);" % field)

    character = urllib.parse.quote(selection)
    url = f"https://hanyu.baidu.com/zici/s?wd={character}&query={character}"
    response = requests.get(url)
    bs = BeautifulSoup(response.text, "html.parser")
    ping = re.sub("\s", "", bs.find("div", {"class": "pronounce"}).text)

    def cb1():
        html = editor.note.fields[field]

        # print("delete_before:",html)

        # 删除pattern[::-1]后面的<br>
        html = html.replace(pattern, "<ruby>")
        html = html.replace(pattern[::-1], f"<rt>{ping}</rt></ruby>")

        editor.note.fields[field] = html
        editor.loadNote()

        # focus the field, so that changes are saved
        editor.web.setFocus()
        editor.web.eval("focusField(%d);" % field)

    editor.saveNow(cb1)

    def cb2():
        editor.web.setFocus()
        editor.web.eval("focusField(%d);" % field)

    editor.saveNow(cb2)


def wrap_pre(editor):
    wrap_in_tags(editor, "pre", "")


def wrap_code(editor):
    wrap_in_tags(editor, "code", "span", "myCodeClass")


def wrap_code_blue(editor):
    wrap_in_tags(editor, "code", "span", "blue-hl")


def wrap_code_pink(editor):
    wrap_in_tags(editor, "code", "span", "pink-hl")


def wrap_prism_go(editor):
    wrap_in_tags(editor, "pre", "code", "go")


def wrap_prism_c(editor):
    wrap_in_tags(editor, "pre", "code", "c")


def wrap_prism_ts(editor):
    wrap_in_tags(editor, "pre", "code", "ts")


def wrap_prism_lua(editor):
    wrap_in_tags(editor, "pre", "code", "lua")


def wrap_prism_regex(editor):
    wrap_in_tags(editor, "pre", "code", "regex")


def wrap_prism_sql(editor):
    wrap_in_tags(editor, "pre", "code", "sql")


def wrap_prism_bash(editor):
    wrap_in_tags(editor, "pre", "code", "bash")


# def wrap_blockquote(editor):
#     wrap_in_tags(editor,"blockquote")
#
# def wrap_kbd(editor):
#     wrap_in_tags(editor, "kbd")


def delete_pre(editor):
    delete_tag(editor, "<pre[^<]+?", "</pre>")


def delete_blockquote(editor):
    delete_tag(editor, "<blockquote>", "</blockquote>")


def addMyButton(buttons, editor):
    # editor._links['button_wrap_pre'] = wrap_pre
    editor._links["button_wrap_code"] = wrap_code
    editor._links["button_wrap_code_blue"] = wrap_code_blue
    editor._links["button_wrap_code_pink"] = wrap_code_pink
    editor._links["button_wrap_go"] = wrap_prism_go
    editor._links["button_wrap_c"] = wrap_prism_c
    editor._links["button_wrap_ts"] = wrap_prism_ts
    editor._links["button_wrap_lua"] = wrap_prism_lua
    editor._links["button_wrap_regex"] = wrap_prism_regex
    editor._links["button_wrap_sql"] = wrap_prism_sql
    editor._links["button_wrap_bash"] = wrap_prism_bash
    # editor._links['button_wrap_blockquote'] = wrap_blockquote
    # editor._links['button_delete_pre'] = delete_pre
    # editor._links['button_delete_blockquote'] = delete_blockquote
    # editor._links['button_wrap_kbd'] = wrap_kbd
    # editor._links['button_wrap_ping'] = wrap_ping

    [buttons.remove(i) for i in buttons if "Insert code block (ctrl+.)" in i]

    return buttons + [
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "gopher_inverse.png"),
            "button_wrap_go",
            "Highlight Go code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "c_icon_inverse.png"),
            "button_wrap_c",
            "Highlight C code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "ts_icon_inverse.png"),
            "button_wrap_ts",
            "Highlight Typescript code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "lua_icon_inverse2.png"),
            "button_wrap_lua",
            "Highlight Lua code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "regex_icon_inverse2.png"),
            "button_wrap_regex",
            "Highlight Regex",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "sql_icon_inverse2.png"),
            "button_wrap_sql",
            "Highlight SQL code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "bash_icon.png"),
            "button_wrap_bash",
            "Highlight Bash code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "code_icon_inverse.png"),
            "button_wrap_code",
            "Inline code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "blue-code.png"),
            "button_wrap_code_blue",
            "Inline code",
        ),
        editor._addButton(
            os.path.join(os.path.dirname(__file__), "icons", "pink-code.png"),
            "button_wrap_code_pink",
            "Inline code",
        ),
    ]

    # editor._addButton(os.path.join(os.path.dirname(__file__),"icons","pre.png"),"button_wrap_pre","Add pre tag for selected text"),
    # editor._addButton(os.path.join(os.path.dirname(__file__), "icons","delete_pre.png"),"button_delete_pre", "Delete pre tag for selected text"),
    # editor._addButton(os.path.join(os.path.dirname(__file__),"icons","blockquote.png"), "button_wrap_blockquote", "Add blockquote tag for selected text"),
    # editor._addButton(os.path.join(os.path.dirname(__file__),"icons","delete_blockquote.png"), "button_delete_blockquote", "Delete blockquote tag for selected text"),
    # editor._addButton(os.path.join(os.path.dirname(__file__),"icons","keyboard.png"), "button_wrap_kbd", "Add kbd tag for selected text"),
    # editor._addButton(None, "button_wrap_ping", "Add kbd tag for selected text","<ruby>拼<rt>pīn</rt>音<rt>yīn</rt></ruby>")]


addHook("setupEditorButtons", addMyButton)
