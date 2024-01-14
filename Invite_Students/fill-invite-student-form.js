// This script auto-fills the Topcon Organisation Invite Co-workers page.
//
// Example invite page:
// https://www.topconpositioning.com/accounts/organization/XXXXXXXXXXXXXX/invite
// Where XXXX... is the org id
//
// Usage:
// 0. Download the student csv from StudyDesk or Faculty Center
// 1. Move the email column to the first column
// 2. Copy the contents of this file (Ctrl + A then Ctrl + C)
// 3. Open Google Chrome (not a different browser)
// 4. Go to the Invite page
// 5. Open Chrome Dev Tools with Ctrl + Shift + I
// 6. Go to the Console tab (up the top)
// 7. Ctrl + V to paste the code
// 8. Press Enter
// 9. A file picker will appear - choose the file that you downloaded in step 0
// 10. Watch the magic unfold
// 11. Press the Invite Members button down the bottom of the page

/* Copyright 2012-2013 Daniel Tillin
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * csvToArray v2.1 (Unminifiled for development)
 *
 * For documentation visit:
 * http://code.google.com/p/csv-to-array/
 *
 */

String.prototype.csvToArray = function (o) {
    var od = {
        'fSep': ',',
        'rSep': '\r\n',
        'quot': '"',
        'head': false,
        'trim': false
    }
    if (o) {
        for (var i in od) {
            if (!o[i]) o[i] = od[i];
        }
    } else {
        o = od;
    }
    var a = [
        ['']
    ];
    for (var r = f = p = q = 0; p < this.length; p++) {
        switch (c = this.charAt(p)) {
        case o.quot:
            if (q && this.charAt(p + 1) == o.quot) {
                a[r][f] += o.quot;
                ++p;
            } else {
                q ^= 1;
            }
            break;
        case o.fSep:
            if (!q) {
                if (o.trim) {
                    a[r][f] = a[r][f].replace(/^\s\s*/, '').replace(/\s\s*$/, '');
                }
                a[r][++f] = '';
            } else {
                a[r][f] += c;
            }
            break;
        case o.rSep.charAt(0):
            if (!q && (!o.rSep.charAt(1) || (o.rSep.charAt(1) && o.rSep.charAt(1) == this.charAt(p + 1)))) {
                if (o.trim) {
                    a[r][f] = a[r][f].replace(/^\s\s*/, '').replace(/\s\s*$/, '');
                }
                a[++r] = [''];
                a[r][f = 0] = '';
                if (o.rSep.charAt(1)) {
                    ++p;
                }
            } else {
                a[r][f] += c;
            }
            break;
        default:
            a[r][f] += c;
        }
    }
    if (o.head) {
        a.shift()
    }
    if (a[a.length - 1].length < a[0].length) {
        a.pop()
    }
    return a;
  }



async function readCsv() {
    let fileHandle;

    // Open a file picker dialog so that you can choose the appropriate csv
    [fileHandle] = await window.showOpenFilePicker();
    const file = await fileHandle.getFile();
    const contents = await file.text();

    // Read the file into an array
    let csvAsArray = contents.csvToArray({
        'fSep': ',',
        'rSep': '\n',
        'quot': '"',
        'head': true,
        'trim': true
    });
    return csvAsArray;
}



function triggerMouseDown (node) {
    triggerMouseEvent (node[0], "mousedown");
}
  
function triggerMouseEvent (node, eventType) {
    var clickEvent = document.createEvent('MouseEvents');
    clickEvent.initEvent (eventType, true, true);
    node.dispatchEvent (clickEvent);
}

// Returns a Promise that resolves after "ms" Milliseconds
const timer = ms => new Promise(res => setTimeout(res, ms))

async function createRows (numRows) {
    // There's already one row on the page
    let existingRows = 1;
    for (var i = 0; i < numRows - existingRows; i++) {
        // Need to select with startswith due to a different suffix being added
        // on each iteration
        var nodes = $('[id^=edit-submit-add]');

        // Need to trigger mousedown event because clicks are prevented
        triggerMouseDown(nodes);

        // Wait 1 second
        await timer(1000);
    }
}

function fillRows (csvAsArray) {
    let numStudents = csvAsArray.length;
    for (var i = 0; i < numStudents; i++) {
      // Pull the email out of the csv array and put it into the next
      // email input
      let email = csvAsArray[i][EMAIL_INDEX];
      document.getElementById(`inviteEmail_${i}`).value = email;
    }
}

// Starting at zero, what column number is the email in?
const EMAIL_INDEX = 0;

async function main() {
    let csvAsArray = await readCsv();
    let numRows = csvAsArray.length;
    await createRows(numRows);
    fillRows(csvAsArray);
}

await main();
