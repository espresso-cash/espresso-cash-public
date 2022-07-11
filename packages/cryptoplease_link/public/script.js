const openDeepLink = function (shouldCopy, deepLink) {
    if (shouldCopy === 'true') {
        CopyToClipboard(deepLink)
    }
    window.location = deepLink;
}

const openInstallLink = function (shouldCopy, deepLink, installLink) {
    if (shouldCopy === 'true') {
        CopyToClipboard(deepLink)
    }
    window.location = installLink;
}