//Функция которая получает данные из URL
function GetURLParameter(sParam) {
    // В окне выбираем первую строку
    var sPageURL = window.location.search.substring(1);
    // делим строку по &
    var sURLVariables = sPageURL.split('&');
    // перебираем полученый массив
    for (var i = 0; i < sURLVariables.length; i++) {
        // делим все значения через=
        var sParameterName = sURLVariables[i].split('=');
        // если значение равно переданному параметру, то возвращаем его значение
        if (sParameterName[0] == sParam) {
            return sParameterName[1];
        }
    }
};


// Одна большая функция для всего документа
// загружается только после того как вся страница прогрузилась
$(document).on('ready turbolinks:load', function() {

    var show_error, stripeResponseHandler, submitHandler;


// Функция перехватывает форму и обрабатывает первично
    submitHandler = function (event) {
        // Записываем данные формы в переменную
        var $form = $(event.target);
        // Деактивируем кнопку
        $form.find("input[type=submit]").prop("disabled", true);
        // Взято с сайта Stripe
        // Если Stripe создался успешно, то отправляем на обработку в функцию
        if (Stripe) {
            Stripe.card.createToken($form, stripeResponseHandler);
        } else {
            show_error("Ошибка отправки данных кредитной карты. Пожалуйста перезагрузите страницу")
        }
        return false;
    };

    // Прослушиваем кнопку с классом сс-form  и при ее нажатии переходим в SubmitHundler
    $(".cc_form").on('submit', submitHandler);

//  Обработчик события при изменении значения в строке Тарифы
    var handlePlanChange = function (plan_type, form) {
        var $form = $(form);
// Если тариф не определен
        if (plan_type == undefined) {
            plan_type = $('#tenant_plan :selected').val();
        }
// Если тариф Премиум
        if (plan_type === 'premium') {
            // Требуем, чтобы были заполнены поля в форме stripe
            $('[data-stripe]').prop('required', true);
            // выключваем кнопку
            $form.off('submit');
            // включаем кнопку, как только получен ответ от Обработчика
            $form.on('submit', submitHandler);

            $('[data-stripe]').show();
        } else {
     // Оставшийся Free тариф
     //        Прячем поля Stripe
            $('[data-stripe]').hide();
            // отключаем отправку полей stripe
            $form.off('submit');
            // отключаем обязательность для полей stripe
            $('[data-stripe]').removeProp('required');
        }
    }

// Прослушивание Изменение Тарифа. и передает значение выбранного поля в обработчик URL
    $("#tenant_plan").on('change', function (event) {
        handlePlanChange($('#tenant_plan :selected').val(), ".cc_form");
    });

// Вызывает обработчик для отслеживания изменения Тарифа
    handlePlanChange(GetURLParameter('plan'), ".cc_form");

// Функция для обработки ответа от Stripe/ очищает поля кредитки
    stripeResponseHandler = function (status, response) {
        var token, $form;

        $form = $('.cc_form');
// Если получили ошибку
        if (response.error) {
            console.log(response.error.message);
            // функция собирает и показывает ошибки
            show_error(response.error.message);
            // показываем ошибки и разблокируем кнопку
            $form.find("input[type=submit]").prop("disabled", false);
        } else {
            // токен получаем из ответа Stripe
            token = response.id;
            // к форме приклепляем скрытое поле с token
            $form.append($("<input type=\"hidden\" name=\"payment[token]\" />").val(token));
            // очищеам поля формы
            $("[data-stripe=number]").remove();
            $("[data-stripe=cvv]").remove();
            $("[data-stripe=exp-year]").remove();
            $("[data-stripe=exp-month]").remove();
            $("[data-stripe=label]").remove();
            // Сабмитим форму
            $form.get(0).submit();
        }
        return false;
    };
    // Отображает ошибки, если Stripe вернулся с ошибками
    show_error = function (message) {
        if ($("#flash-messages").size() < 1) {
            $('div.container.main div:first').prepend("<div id='flash-messages'></div>")
        }
        $("#flash-messages").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div></div>');
        $('.alert').delay(5000).fadeOut(3000);
        return false;
    };
});
