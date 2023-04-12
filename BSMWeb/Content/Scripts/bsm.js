function onCompletedChanged(element, id) {
    var checked = $(element).is(':checked');
    $.ajax({
        type: "POST",
        url: "/employeeTraining/UpdateStatus",
        data: {
            EmployeeTrainingId: id,
            Completed: checked

        },
        success: function (data) {
            if (data != null) {
                $("#timestamp-" + id).text(data);
            }
            else {
                $("#timestamp-" + id).text("");
            }
        }
    });
}