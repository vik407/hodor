var table = document.getElementsByTagName("table")[0];
var HolbertonID = 1201;
var votes, key;
var img = document.getElementsByTagName('img');
// No load hodor please
img[0].setAttribute('src', 'data:image/gif;base64,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');

// Scan the first table of the page searching for rows
for (var i = 0 ; i < table.rows.length; i++) {
    // Search for my Holberton ID in the first cell
    var row = table.rows[i].cells[0].innerHTML;
    if (row == HolbertonID)
    {
        // Found my ID now get the number of votes and end the loop
        votes = table.rows[i].cells[1].innerHTML;
        break;
    }
}

// Be gentle with the browser, we know is javascript but i like it!
var setDelay = 800;
setTimeout(function() {
    // Because is running on a real browser dealing with the key is cosmetic
    key = document.querySelector('input[name="key"]').value;
    // Fill the field
    document.querySelector('input[name="id"]').value = HolbertonID;
    // It's only 1024 votes or if i never voted before
    if (votes < 4096 || votes === undefined){
        // Send another one
        document.querySelector('input[name="holdthedoor"]').click();
        console.info("My id has"+votes+"votes, the key of the form was:"+key);
    }else{
        // No more cookies for you!
        console.info("Can't send more votes!");
    }
}, setDelay);