const openDeepLink = function (shouldCopy, deepLink) {
    if (shouldCopy) {
        CopyToClipboard(deepLink)
    }
    window.location = deepLink;
}

const openInstallLink = function (shouldCopy, deepLink, installLink) {
    if (shouldCopy) {
        CopyToClipboard(deepLink)
    }
    window.location = installLink;
}