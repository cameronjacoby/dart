var Filters = angular.module('Filters', []);

Filters.filter('sanitize', ['$sce', function ($sce) {
  return function (htmlCode) {
    return $sce.trustAsHtml(htmlCode);
  };
}]);

Filters.filter('sanitizePreview', ['$sce', function ($sce) {
  return function (htmlCode) {
    if (htmlCode.length <= 500){
      return $sce.trustAsHtml(htmlCode);
    }

    if (/\s/.test(htmlCode[501]) && !(/\s|\.|\,|\!|\:|\-|\||\{|\}/.test(htmlCode[500]))){
      return $sce.trustAsHtml(htmlCode.slice(0, 501) + '&#8230;');
    }

    for (var i = 500; i >= 0; i -= 1) {
      if (/\s/.test(htmlCode[i]) && !(/\s|\.|\,|\!|\:|\-|\||\{|\}/.test(htmlCode[i - 1]))) {
        return $sce.trustAsHtml(htmlCode.slice(0, i) + '&#8230;');
      }
    }
  };
}]);