
// Provide a default path to dwr.engine
if (dwr == null) var dwr = {};
if (dwr.engine == null) dwr.engine = {};
if (DWREngine == null) var DWREngine = dwr.engine;

if (TinyMceDWRFacade == null) var TinyMceDWRFacade = {};
TinyMceDWRFacade._path = '/webapps/rubric/dwr_open';
TinyMceDWRFacade.getLocalizedString = function(p0, callback) {
  dwr.engine._execute(TinyMceDWRFacade._path, 'TinyMceDWRFacade', 'getLocalizedString', p0, callback);
}
TinyMceDWRFacade.getViewUrl = function(p0, callback) {
  dwr.engine._execute(TinyMceDWRFacade._path, 'TinyMceDWRFacade', 'getViewUrl', p0, callback);
}
TinyMceDWRFacade.filterHtml = function(p0, callback) {
  dwr.engine._execute(TinyMceDWRFacade._path, 'TinyMceDWRFacade', 'filterHtml', p0, callback);
}
TinyMceDWRFacade.getBaseURL = function(callback) {
  dwr.engine._execute(TinyMceDWRFacade._path, 'TinyMceDWRFacade', 'getBaseURL', callback);
}
TinyMceDWRFacade.getLocation = function(p0, callback) {
  dwr.engine._execute(TinyMceDWRFacade._path, 'TinyMceDWRFacade', 'getLocation', p0, callback);
}
TinyMceDWRFacade.initContextFromRequestHeader = function(callback) {
  dwr.engine._execute(TinyMceDWRFacade._path, 'TinyMceDWRFacade', 'initContextFromRequestHeader', false, callback);
}
