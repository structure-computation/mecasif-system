// Generated by CoffeeScript 1.4.0
var SiteMenuView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

SiteMenuView = (function(_super) {

  __extends(SiteMenuView, _super);

  function SiteMenuView(el, model, params) {
    var key, val;
    this.el = el;
    this.model = model;
    if (params == null) {
      params = {};
    }
    SiteMenuView.__super__.constructor.call(this, this.model);
    for (key in params) {
      val = params[key];
      this[key] = val;
    }
    this.content = new_dom_element({
      id: "sidebar",
      className: "sidebar",
      parentNode: this.el,
      style: {
        paddingTop: "54px"
      }
    });
  }

  return SiteMenuView;

})(Process);
