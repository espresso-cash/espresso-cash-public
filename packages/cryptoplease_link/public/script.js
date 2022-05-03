document.querySelectorAll('.js-copy').forEach(element => {
    element.addEventListener('click', function (e) {
        navigator.clipboard.writeText('{{ deepLink }}');
    });
});
