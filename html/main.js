$(function() {
    window.addEventListener("message", function(event) {
        var selector = document.querySelector("#carhud")
        selector.style = "opacity:1.0;";
        if (event.data.pauseMenu == false) {

            var bs = document.getElementById("belt-sound");
            bs.value = 0.1;

            if (event.data.inVehicle == false) {

                document.querySelector("#carhud").style = "opacity:0.0;";
                bs.pause();
            } else {

                document.getElementById("num-gear").innerHTML = "   " + event.data.gear + " ";

                $('#fuel-load').css({ 'width': event.data.fuel + '%' });
                $('.fuel-text').text(event.data.fuel + "");
                $('#engine-load').css({ 'width': (event.data.engine / 10) + '%' });
                document.getElementById("num-khm").innerHTML = event.data.kmh;
                document.getElementById("cityzone").innerHTML = " < " + event.data.zone + " > ";
                document.querySelector("#carhud").style = "opacity:1.0;";

                if (event.data.speedlimit) {
                    $('#speedlimit').css({ 'fill': 'rgb(255, 238, 0)' });
                } else {
                    $('#speedlimit').css({ 'fill': 'white' });
                }

                if (event.data.belt) {
                    $('#belt').css({ 'fill': 'rgb(251, 255, 0)' });
                    document.getElementById("belt").classList.remove("pp");
                    bs.pause();
                } else {
                    $('#belt').css({ 'fill': 'white' });
                    document.getElementById("belt").classList.add("pp");
                    bs.play();
                }

                if (event.data.cruise) {
                    $('#cruise').css({ 'color': 'rgb(255, 238, 0)' });
                } else {
                    $('#cruise').css({ 'color': 'white' });
                }

                if (event.data.isCar != true) {
                    bs.pause();
                    document.getElementById("belt").classList.remove("pp");
                }

            }
        } else {
            var selector = document.querySelector("#carhud")
            selector.style = "opacity:0.0;"
                // bs.pause();
        }
    })
})

$(function () {
    window.addEventListener('message',(event) => {
        var item = event.data;
        if (item.type === "vehicle") {
            $(".hud-car").show();

            if(item.motor == "motor") {
                $('#car').attr('src','img/motorvector.png');
                $('#wheel').hide()
                $('#wheel4').hide()
            }else {
                $('#car').attr('src','img/carvector.png');
                $('#car1').attr('src','img/nick.png');
                $('#wheel').show()
                $('#wheel4').show()
            }

            if (item.health == 100 && item.motor === "car") {
                $('#car').attr('src','img/carvector10.png');
                $('#car1').attr('src','img/nick1.png');
            }else if(item.health < 250 && item.motor === "car") {
                $('#car').attr('src','img/carvector20.png');
            }else if(item.health < 400 && item.motor === "car") {
                $('#car').attr('src','img/carvector40.png');
            }else if(item.health < 600 && item.motor === "car") {
                $('#car').attr('src','img/carvector60.png');
            }else if(item.health > 600 && item.motor === "car") {
                $('#car').attr('src','img/carvector.png');
            }else if(item.health == 100 && item.motor === "motor") {
                $('#car').attr('src','img/motorvector10.png');
            }else if(item.health < 400 && item.motor === "motor") {
                $('#car').attr('src','img/motorvector40.png');
            }else if(item.health < 600 && item.motor === "motor") {
                $('#car').attr('src','img/motorvector60.png');
            }else if(item.health > 600 && item.motor === "motor") {
                $('#car').attr('src','img/motorvector.png');
            }

       
            if (item.w1 == "acc") {
                $('#wheel2').attr('src','img/wheel_pink.png');
            }else if(item.w1 == "die") {
                $('#wheel2').attr('src','img/wheel_red.png');
            }else if(item.w1 == "som") {
                $('#wheel2').attr('src','img/wheel.png');
            }
            if (item.w2 == "acc") {
                $('#wheel').attr('src','img/wheel_pink.png');
            }else if(item.w2 == "die") {
                $('#wheel').attr('src','img/wheel_red.png');
            }else if(item.w2 == "som") {
                $('#wheel').attr('src','img/wheel.png');
            }
            if (item.w3 == "acc") {
                $('#wheel3').attr('src','img/wheel_pink.png');
            }else if(item.w3 == "die") {
                $('#wheel3').attr('src','img/wheel_red.png');
            }else if(item.w3 == "som") {
                $('#wheel3').attr('src','img/wheel.png');
            }
            if (item.w4 == "acc") {
                $('#wheel4').attr('src','img/wheel_pink.png');
            }else if(item.w4 == "die") {
                $('#wheel4').attr('src','img/wheel_red.png');
            }else if(item.w4 == "som") {
                $('#wheel4').attr('src','img/wheel.png');
            }

            
        }else if (item.type === "out") {
            $(".hud-car").hide();
       
        }
    })
})