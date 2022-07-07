const jscopy = function (shouldCopy, deepLink, installLink) {
    if (shouldCopy === 'true') {
        // TODO: change it to CopyToClipboard(deepLink)
        CopyToClipboard('https://solana1.cryptoplease.link/?key=R6onb4LApxwQYGKosxiRGC')
    }
    window.location = installLink;
}