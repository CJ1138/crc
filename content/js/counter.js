const apikey = config.API_KEY;

function counter(){
    fetch('https://crc-api-gateway-5fntyvv6.nw.gateway.dev/visits?key=' + apikey, {
    method: 'POST'})
    .then((response) => response.json())
    .then((data) => {
        document.getElementById("counter").innerHTML = 
            '<span>You are visitor number: </span><span id="count">' + data + '</span>';
})};

counter();