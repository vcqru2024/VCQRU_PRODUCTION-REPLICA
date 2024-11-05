document.getElementById("subscribe").innerHTML =
    '<div class="container">' +
    '<div class="row g-xl-4 g-md-3 g-3 align-items-center">' +
    '<div class="col-lg-8">' +
    '<div class="web-heading">' +
    '<h1>Subscribe Our Newsletter</h1>' +
    '<p>Join VCQRU\'s knowledge hub to keep yourself updated with the latest updates.</p>' +
    '</div>' +
    '</div>' +
    '<div class="col-lg-4">' +
    '<div id="subscribe-send" style="display: none;">' +
    '<h5>Thank you for subscribing</h5>' +
    '</div>' +
    '<form action="" class="needs-validation position-relative" novalidate id="sub" method="Post">' +
    '<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email Id*" required>' +
    '<button type="button" onclick="submitSub()" class="btn btn-primary btn-sm">Join</button>' +
    '<div class="invalid-feedback">Required*</div>' +
    '</form>' +
    '</div>' +
    '</div>' +
    '</div>';

function submitSub() {
    // Show loading spinner
    document.getElementById('loader-wrapper').style.visibility = 'visible';

    // Get form values
    var email = document.getElementById('email').value;
    // Validate form
    if (email == "") {
        (() => {
            'use strict'
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('#sub')

            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        })();
        // Hide loading spinner
        document.getElementById('loader-wrapper').style.visibility = 'hidden';
        return false;
    }

    // Create a new XMLHttpRequest object
    var xhr = new XMLHttpRequest();

    // Define the AJAX request

    // xhr.open('POST', 'https://qa.vcqru.com/Info/MasterHandler.ashx?method=sendquerySubscribed&email=' + encodeURIComponent(email), true);
    xhr.open('POST', 'https://www.vcqru.com/Info/MasterHandler.ashx?method=sendqueryMVCNews&email=' + encodeURIComponent(email) + '&name=User', true);

    // Set the content type for POST requests
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

    // Define the callback function when the request is successful
    xhr.onload = function () {
        // Hide loading spinner
        document.getElementById('loader-wrapper').style.visibility = 'hidden';
        if (xhr.status === 200) {
            // Reset form fields to null
            document.getElementById('sub').reset();
            // Redirect to ../thank-you.aspx after a successful form submission
            // window.location.href = '../thank-you.aspx';
            document.getElementById('subscribe-send').style.display = 'block';
            document.getElementById('sub').style.display = 'none';
        }
    };

    // Define the callback function in case of an error
    xhr.onerror = function (error) {
        // Hide loading spinner
        console.error('Error:', error);
    };

    // Send the request
    xhr.send();
}

document.onreadystatechange = function () {
    var loaderWrapper = document.getElementById('loader-wrapper');
    if (document.readyState === 'loading') {
        loaderWrapper.style.visibility = 'visible';
    } else {
        loaderWrapper.style.visibility = 'hidden';
    }
};