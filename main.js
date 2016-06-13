/**
	All Commented file names are still a WIP
*/

var ___sdpBaseDir = 'mods/SpartanDevProject/js/api/'
var ___sdpObjsDir = base+'/objects/'
var files = [base+'core.js', base+'util.js', base+'patches.js', base+'storage.js', base+'log.js', base+'graphical.js', base+'patches.js', base+'/3rd/jstorage.js', base+'patches.js', objs+'company.js', objs+'contracts.js', objs+'date.js', objs+'event.js', objs+'notification.js', objs+'platform.js', objs+'publisher.js', objs+'research.js', /*objs+'research_project.js',*/ /*objs+'reviewer.js',*/ objs+'topic.js', /*objs+'training.js',*/ objs+'weight.js', objs+'/util/enum.js', objs+'util/map.js', objs+'util/util.js']

GDT.loadJs(files, function() {}, function() {});