function counter(){
    fetch('https://crc-api-gateway-5fntyvv6.nw.gateway.dev/visits', {
    method: 'POST'})
    .then((response) => response.json())
    .then((data) => {
        document.getElementById("counter").innerHTML = 
            '<h4>You are visitor number: ' + data + '</h4>';
})};

counter();