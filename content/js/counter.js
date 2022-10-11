function counter(){
    fetch('https://vc-api-gw-azia0w6p.nw.gateway.dev/visits?key=AIzaSyB6XidRlzrbQrGdIVOCTBiNUeVFp2SXQaY', {
    method: 'POST'})
    .then((response) => response.json())
    .then((data) => {
        document.getElementById("counter").innerHTML = 
            '<span>You are visitor number: </span><span id="count">' + data + '</span>';
})};

counter();