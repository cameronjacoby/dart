var Filters = angular.module('Filters', []);

Filters.filter('sanitize', ['$sce', function ($sce) {
  return function (htmlCode) {
    return $sce.trustAsHtml(htmlCode);
  };
}]);

Filters.filter('sanitizeLimit', ['$sce', function ($sce) {
  return function (htmlCode, limit, jobId) {
    var link = '<a href="/jobs/' + jobId + '" class="normal">Learn more &raquo;</a>';

    if (htmlCode.length <= limit){
      return $sce.trustAsHtml(htmlCode + ' ' + link);
    }

    if (/\s/.test(htmlCode[limit + 1]) && !(/\s|\W|\_/.test(htmlCode[limit]))){
      return $sce.trustAsHtml(htmlCode.slice(0, limit + 1) + '&#8230; ' + link);
    }

    for (var i = limit; i >= 0; i -= 1) {
      if (/\s/.test(htmlCode[i]) && !(/\s|\W|\_/.test(htmlCode[i - 1]))) {
        return $sce.trustAsHtml(htmlCode.slice(0, i) + '&#8230; ' + link);
      }
    }
  };
}]);