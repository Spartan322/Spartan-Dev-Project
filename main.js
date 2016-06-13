/**
	All Commented file names are still a WIP
*/
var SDP = SDP || {}
var Companies = Companies || {}
var JobApplicants = JobApplicants || {}

var ___sdpBaseDir = 'mods/SpartanDevProject/js/api/'
var ___sdpObjsDir = ___sdpBaseDir+'/objects/'
var files = [___sdpBaseDir+'core.js', ___sdpBaseDir+'util.js', ___sdpBaseDir+'patches.js', ___sdpBaseDir+'storage.js', ___sdpBaseDir+'log.js', ___sdpBaseDir+'graphical.js', ___sdpBaseDir+'patches.js', ___sdpBaseDir+'/3rd/jstorage.js', ___sdpBaseDir+'patches.js', ___sdpObjsDir+'company.js', ___sdpObjsDir+'contracts.js', ___sdpObjsDir+'date.js', ___sdpObjsDir+'event.js', ___sdpObjsDir+'notification.js', ___sdpObjsDir+'platform.js', ___sdpObjsDir+'publisher.js', ___sdpObjsDir+'research.js', /*___sdpObjsDir+'research_project.js',*/ /*___sdpObjsDir+'reviewer.js',*/ ___sdpObjsDir+'topic.js', /*___sdpObjsDir+'training.js',*/ ___sdpObjsDir+'weight.js', ___sdpObjsDir+'/util/enum.js', ___sdpObjsDir+'util/map.js', ___sdpObjsDir+'util/util.js']

GDT.loadJs(files, function() {}, function() {});