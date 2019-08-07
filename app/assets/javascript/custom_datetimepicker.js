$(document).on('turbolinks:load', function () {
    $('.datetimepicker').datetimepicker({
        format: 'MM/DD/YYYY',
        // minDate: moment(),
        sideBySide: true,
        icons: {
            up: "fas fa-angle-up",
            down: "fas fa-angle-down",
            previous: "fas fa-angle-left",
            next: "fas fa-angle-right"
        }
    });
});