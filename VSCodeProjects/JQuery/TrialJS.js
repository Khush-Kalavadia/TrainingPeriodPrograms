executePOSTRequest: function (request)
{
    app.doNotHideLoaderScreens.push(request.url);

    $.ajax({
            url: request.url,

            type: "POST",

            cache: false,

            data: request.params,

            timeout: 180000,

            success: function (json)
            {
                if(app.doNotHideLoaderScreens.indexOf(request.url) != appConstant.NotAvailable)
                {
                    app.doNotHideLoaderScreens.splice(app.doNotHideLoaderScreens.indexOf(request.url), 1);
                }

                var callbacks;

                if (request.callback != undefined)
                {
                    callbacks = $.Callbacks();

                    callbacks.add(request.callback);

                    request.json = json;

                    callbacks.fire(request);

                    callbacks.remove(request.callback);

                }

            },


            error: function(request, status, error)
            {
                if(status == "timeout")
                {
                    loaderUtil.hideModalLoader();

                    loaderUtil.hideCentralModalLoader();

                    $(".spinner,.overlay,.pace-loading").remove();

                    appUtil.displayBigInfoNotification("Request Timeout", "The server timed out waiting for the request");
                }

                if(status == 'parsererror')
                {
                    location.href = 'login.jsp'; //  For cross site scripting js injection
                }

            },

            dataType: "json"
        });
};

app.executePOSTRequest({url: 'runScheduler',params:{schedulerId:$(event.currentTarget).data('value')}, callback: schedulerManager.afterJobTriggered});
