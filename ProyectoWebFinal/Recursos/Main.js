function App() { }

window.onload = function (event) {
    var app = new App();
    window.app = app;
    app.loadCars();
};

App.prototype.loadCars = function () {
    var xhttp = new XMLHttpRequest();
    var app = this;

    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            app.updateCarousel(this.responseText);
        }
    };

    xhttp.open("GET", "/Principal/Autos", true);
    xhttp.send();
};

App.prototype.processingButton = function (event) {
    const btn = event.currentTarget;
    const slickList = event.currentTarget.parentNode;
    const track = event.currentTarget.parentNode.querySelector('#track');
    const slick = track.querySelectorAll('.slick');

    const slickWidth = slick[0].offsetWidth;

    const trackWidth = track.offsetWidth;
    const listWidth = slickList.offsetWidth;

    track.style.left == "" ? leftPosition = track.style.left = 0 : leftPosition = parseFloat(track.style.left.slice(0, -2) * -1);

    btn.dataset.button == "button-prev" ? prevAction(leftPosition, slickWidth, track) : nextAction(leftPosition, trackWidth, listWidth, slickWidth, track);
}

let prevAction = (leftPosition, slickWidth, track) => {
    if (leftPosition > 0) {
        console.log("entro 2")
        track.style.left = `${-1 * (leftPosition - slickWidth)}px`;
    }
}

let nextAction = (leftPosition, trackWidth, listWidth, slickWidth, track) => {
    if (leftPosition < (trackWidth - listWidth)) {
        track.style.left = `${-1 * (leftPosition + slickWidth)}px`;
    }
}
App.prototype.updateCarousel = function (htmlContent) {
    var track = document.getElementById('inner');
    track.innerHTML = htmlContent;

    // Resto de tu código existente para configurar el carrusel
    // ...

    // Llama a tu función existente para inicializar el carrusel
    this.initCarousel();
};

App.prototype.initCarousel = function () {
    // Aquí debes poner tu código para inicializar el carrusel.
    // Por ejemplo, puedes llamar a la función processingButton:
    this.processingButton({ currentTarget: document.getElementById('button-next') });
    // O cualquier otra lógica que necesites para configurar el carrusel.
};
