if (document.location.pathname == '/' || document.location.pathname.indexOf('/news') == 0) {
  new TimeRestriction({minutes: 15}, {hours: 6});
}
