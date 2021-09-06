$(document).ready(function () {

    $("div.questions div.question").each(function (e) {
        if (e != 0)
            $(this).hide();
    });

    $("#btn_next").click(function () {
        if ($("div.questions div.question:visible").next().length != 0)
            $("div.questions div.question:visible").next().show().prev().hide();
        else {
            $("#btn_next").hide();
            $("div.questions").hide();
            $("div.quizComplete").show();
        }
        $("#btn_next").attr("disabled", true);
        return false;
    });

    $("input.answer").click(function () {
        $("#btn_next").removeAttr("disabled");
    });

    // Add a window close listener to alert user they may not want to close.
    window.addEventListener("beforeunload", windowClosing);
    function windowClosing(e) {
        var confirmationMessage = "Are you sure you want to leave the page? Changes may not be saved.";
        (e || window.event).returnValue = confirmationMessage;
        return confirmationMessage;
    }

    // Remove the listener when the submit button is clicked.
    $("#btn_submit").click(function () {
        window.removeEventListener("beforeunload", windowClosing);
    });

});