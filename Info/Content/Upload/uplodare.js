function addFileUploadBox() {
    if (!document.getElementById || !document.createElement)
        return false;

    var uploadArea = document.getElementById("upload-area");

    if (!uploadArea)
        return;

    var newLine = document.createElement("br");
    // uploadArea.appendChild (newLine);

    var newUploadBox = document.createElement("input");

    // Set up the new input for file uploads
    newUploadBox.type = "file";
    newUploadBox.size = "60";

    // The new box needs a name and an ID
    if (!addFileUploadBox.lastAssignedId)
        addFileUploadBox.lastAssignedId = 100;

    newUploadBox.setAttribute("id", "dynamic" + addFileUploadBox.lastAssignedId);
    newUploadBox.setAttribute("name", "dynamic:" + addFileUploadBox.lastAssignedId);
    uploadArea.appendChild(newUploadBox);
    document.getElementById('dynamic' + addFileUploadBox.lastAssignedId).addEventListener('change', handleFileSelect, false);
    addFileUploadBox.lastAssignedId++;

}

function handleFileSelect(evt) {
    evt.target.style.display = "none";
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

        // Only process image files.
        if (!f.type.match('image.*')) {
            continue;
        }

        var reader = new FileReader();

        // Closure to capture the file information.
        reader.onload = (function (theFile) {
            return function (e) {
                // Render thumbnail.
                var span = document.createElement('div');
                span.innerHTML = ['<div  onclick="deteleFile(this.parentNode,\'' + evt.target.id + '\')" ></div>  <img class="thumb" src="', e.target.result,
                            '" title="', theFile.name, '"/>'].join('');
                document.getElementById('ctl00_ContentPlaceHolder1_list').insertBefore(span, null);

            };
        })(f);

        // Read in the image file as a data URL.
        reader.readAsDataURL(f);
    }
    addFileUploadBox();
}
function deteleFile(obj, deleteid) {
    var upl = document.getElementById("upload-area");
    var f1 = document.getElementById(deleteid);
    if(f1!=null)
     upl.removeChild(f1);  
    obj.style.display = "none"; 

}

function DeleteFile(obj, fname) {
    deteleFile(obj.parentNode, fname);
    PageMethods.DeleteWebFile(fname, onCompleteDelete);
}
function onCompleteDelete(result) {
  
}

