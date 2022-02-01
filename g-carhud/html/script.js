$(function () {
    showCarHud(false)
    function showCarHud(bool) {
        if (bool) {
            $(".box").fadeIn(300);
        } else {
            $(".box").fadeOut(300);
        }
    }

    function initCarhud(data) {
        $(".velocidad2").text(Math.round(data.speed) + "");
        $(".progressFuel").css("height", (data.fuel) * 0.18 + "");
        $(".marchas-texto").text((data.engine));
        $(".rpm").css("width", (data.speed) * 0.45 + "");
        showCarHud(true)
        // DAÑO DEL VEHICULO
        const daño = data.damage /10;
        if (daño > 80 && daño <= 100) {
            $("#engine-icon").css(
                {
                    color: "green",
                }
            )
        } else if (daño > 50 && daño < 79) {
            $("#engine-icon").css(
                {
                    color: "yellow",
                }
            )
        } else if (daño > 30 && daño < 49) {
            $("#engine-icon").css(
                {
                    color: "orange",
                }
            )
        } else if (daño > 0 && daño < 29) {
            $("#engine-icon").css(
                {
                    color: "red",
                }
            )
        }
        if (data.engine == 0) {
            $(".marchas-texto").text("R");
        }
    }
    window.addEventListener('message',  function(event){
        let v =  event.data;
        if (v.action == 'speedometer') {
            initCarhud(v);
        } else if (v.action == 'hideSpeedo') {
            showCarHud(false);
        }
    })
});
// JS Made by Barikeloo#9927 with love <3