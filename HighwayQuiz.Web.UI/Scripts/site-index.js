
$(document).ready(function () {
    $("#tbx_emailAddress").focus();
});


function validateUserForm(e) {

    var isFormValid = true;
    var validateEmail = true;

    $("div#divErrMsg").empty();

    // Look at each form input. If it's blank, then get the description from the
    // input label and add it to the error message.
    $("form#frmUser :input.required").each(function () {
        if ($(this).val() == "") {
            var desc = $("label[for='" + $(this).attr('id') + "']").text();
            $("div#divErrMsg").append("<span>" + desc + " is required</span>");            
            isFormValid = false;

            $(this).focus(); // This will focus the last blank control.

            // If Email input is blank, there's no need to validate it further.
            if (desc.toUpperCase() == "EMAIL")
                { validateEmail = false; }
        }
    });  

    if (validateEmail && !isValidEmailAddress($("#tbx_emailAddress").val() )) {
        $("div#divErrMsg").append("<span>Email Address is invalid</span>");
        $("#tbx_emailAddress").focus();
        isFormValid = false;
    }

    // If the form is not valid, then show the errors.
    if (!isFormValid) {
        $("div#divErrMsg").show();
    }

    return isFormValid;
}


function isValidEmailAddress(emailAddress) {

    var isValid = false;

    // This is a syncronous call, so it will wait for the api response to return value.
    jQuery.ajax({
        url: "HighwayQuizWebService.asmx/IsValidEmailAddress",
        type: "POST",
        contenttype: "application/json; charset=utf-8",
        data: { "emailAddress": emailAddress },
        async: false,
        error: function (msg) {
            // If there is an issue calling the webservice, log it to console and
            // just return true. The back end will still validate the address.
            // Will just assume client side it's ok.
            console.log(msg.responseText);
            isValid = true;
        },
        success: function (response) {
            isValid = (response.toUpperCase() === 'TRUE');;
        }
    });

    return isValid;

} 