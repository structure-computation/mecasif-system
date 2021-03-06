// Generated by CoffeeScript 1.4.0
var CodeView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

CodeView = (function(_super) {

  __extends(CodeView, _super);

  function CodeView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    CodeView.__super__.constructor.call(this, this.site_item);
    this.pre = new_dom_element({
      parentNode: this.el,
      nodeName: "pre",
      className: this.site_item.type,
      txt: this.site_item.txt,
      style: {
        fontSize: "10px",
        background: "#d9e0e7"
      }
    });
    hljs.highlightBlock(this.pre);
  }

  return CodeView;

})(Process);
// Generated by CoffeeScript 1.4.0
var TreeView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TreeView = (function(_super) {

  __extends(TreeView, _super);

  function TreeView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    TreeView.__super__.constructor.call(this, this.site_item);
    this.jstree = new_dom_element({
      id: this.site_item.id.get(),
      className: "jstree jstree-1 jstree-default",
      parentNode: this.el
    });
    this.render(this.site_item, this.jstree);
  }

  TreeView.prototype.render = function(item, el) {
    var child, i, li, _i, _j, _len, _ref, _ref1, _results;
    if (item._children.length > 0) {
      this.ul = new_dom_element({
        nodeName: "ul",
        parentNode: el
      });
      li = [];
      _ref = item._children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        if (child.type.get() === "file") {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{ "icon" : "fa fa-file fa-lg text-primary" }',
            txt: child.txt.get()
          }));
        } else if (child.type.get() === "symlink") {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{ "icon" : "fa fa-link fa-lg text-primary" }',
            txt: child.txt.get()
          }));
        } else if (child.type.get() === "opened") {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{"opened":true, "icon" : "fa fa-folder fa-lg text-warning" }',
            txt: child.txt.get()
          }));
        } else {
          li.push(new_dom_element({
            nodeName: "li",
            parentNode: this.ul,
            datajstree: '{"opened":false, "icon" : "fa fa-folder fa-lg text-warning" }',
            txt: child.txt.get()
          }));
        }
      }
      _results = [];
      for (i = _j = 0, _ref1 = item._children.length - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 0 <= _ref1 ? ++_j : --_j) {
        _results.push(this.render(item._children[i], li[i]));
      }
      return _results;
    }
  };

  return TreeView;

})(Process);
// Generated by CoffeeScript 1.4.0
var GalleryView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

GalleryView = (function(_super) {

  __extends(GalleryView, _super);

  function GalleryView(site_item, el) {
    var i, _i, _ref;
    this.site_item = site_item;
    this.el = el;
    GalleryView.__super__.constructor.call(this, this.site_item);
    this.row = new_dom_element({
      className: "row",
      parentNode: this.el
    });
    this.width = "col-sm-6 col-md-" + this.site_item.col.get() + " col-lg-6";
    for (i = _i = 0, _ref = this.site_item.lst.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      this.col = new_dom_element({
        parentNode: this.row,
        className: this.width
      });
      if (this.site_item.lst_href[i]) {
        this.a = new_dom_element({
          nodeName: "a",
          parentNode: this.col,
          href: this.site_item.lst_href[i],
          target: "_blank"
        });
      } else {
        this.a = new_dom_element({
          nodeName: "a",
          parentNode: this.col
        });
      }
      this.image = new_dom_element({
        className: "image-info text-center",
        parentNode: this.a
      });
      this.image_inner = new_dom_element({
        className: "image-inner text-center",
        parentNode: this.image
      });
      this.i = new_dom_element({
        nodeName: "img",
        parentNode: this.image_inner,
        src: this.site_item.lst[i],
        style: {
          height: this.site_item.height.get()
        }
      });
      if (this.site_item.lst_captions[i] != null) {
        this.t = new_dom_element({
          nodeName: "h5",
          className: "text-center",
          parentNode: this.image,
          txt: this.site_item.lst_captions[i]
        });
      }
    }
  }

  return GalleryView;

})(Process);
// Generated by CoffeeScript 1.4.0
var TitleView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TitleView = (function(_super) {

  __extends(TitleView, _super);

  function TitleView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    TitleView.__super__.constructor.call(this, this.site_item);
    this.page_header = new_dom_element({
      parentNode: this.el,
      nodeName: "h1",
      className: "page-header",
      txt: this.site_item.title.get()
    });
  }

  return TitleView;

})(Process);
// Generated by CoffeeScript 1.4.0
var ParagraphView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ParagraphView = (function(_super) {

  __extends(ParagraphView, _super);

  function ParagraphView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    ParagraphView.__super__.constructor.call(this, this.site_item);
    this.p = new_dom_element({
      nodeName: "p",
      parentNode: this.el,
      txt: this.site_item.txt.get()
    });
  }

  return ParagraphView;

})(Process);
// Generated by CoffeeScript 1.4.0
var TableView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TableView = (function(_super) {

  __extends(TableView, _super);

  function TableView(site_item, el) {
    var i, j, _i, _j, _ref, _ref1;
    this.site_item = site_item;
    this.el = el;
    TableView.__super__.constructor.call(this, this.site_item);
    this.table = new_dom_element({
      nodeName: "table",
      className: "table",
      parentNode: this.el
    });
    this.thead = new_dom_element({
      nodeName: "thead",
      parentNode: this.table
    });
    for (i = _i = 0, _ref = this.site_item.lst.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      this.tr = new_dom_element({
        nodeName: "tr",
        parentNode: this.thead
      });
      for (j = _j = 0, _ref1 = this.site_item.lst[i].length; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
        this.td = new_dom_element({
          nodeName: "td",
          parentNode: this.tr,
          txt: this.site_item.lst[i][j],
          style: {
            verticalAlign: "middle"
          }
        });
      }
    }
  }

  return TableView;

})(Process);
// Generated by CoffeeScript 1.4.0
var PanelView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

PanelView = (function(_super) {

  __extends(PanelView, _super);

  function PanelView(site_item, el) {
    var fa_collapse, fa_expand, panel_content, panel_title;
    this.site_item = site_item;
    this.el = el;
    PanelView.__super__.constructor.call(this, this.site_item);
    this.panel_inverse = new_dom_element({
      parentNode: this.el,
      className: "panel panel-inverse",
      id: this.site_item.balise
    });
    this.panel_heading = new_dom_element({
      parentNode: this.panel_inverse,
      className: "panel-heading"
    });
    this.panel_heading_btn = new_dom_element({
      parentNode: this.panel_heading,
      className: "panel-heading-btn"
    });
    this.expand = new_dom_element({
      parentNode: this.panel_heading_btn,
      nodeName: "a",
      className: "btn btn-xs btn-icon btn-circle btn-default",
      href: "javascript:;",
      dataclick: "panel-expand"
    });
    fa_expand = new_dom_element({
      parentNode: this.expand,
      nodeName: "i",
      className: "fa fa-expand"
    });
    this.collapse = new_dom_element({
      parentNode: this.panel_heading_btn,
      nodeName: "a",
      className: "btn btn-xs btn-icon btn-circle btn-warning",
      href: "javascript:;",
      dataclick: "panel-collapse"
    });
    fa_collapse = new_dom_element({
      parentNode: this.collapse,
      nodeName: "i",
      className: "fa fa-minus"
    });
    panel_title = new_dom_element({
      parentNode: this.panel_heading,
      nodeName: "h2",
      className: "panel-title",
      txt: this.site_item.title.get()
    });
    panel_content = new_dom_element({
      id: this.site_item.id.get(),
      parentNode: this.panel_inverse,
      className: "panel-body"
    });
  }

  return PanelView;

})(Process);
// Generated by CoffeeScript 1.4.0
var RowView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

RowView = (function(_super) {

  __extends(RowView, _super);

  function RowView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    RowView.__super__.constructor.call(this, this.site_item);
    this.section = new_dom_element({
      parentNode: this.el,
      nodeName: "section",
      datascrollview: "true"
    });
    this.row = new_dom_element({
      parentNode: this.section,
      className: "row",
      id: this.site_item.id.get()
    });
  }

  return RowView;

})(Process);
// Generated by CoffeeScript 1.4.0
var ColView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ColView = (function(_super) {

  __extends(ColView, _super);

  function ColView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    ColView.__super__.constructor.call(this, this.site_item);
    this.width = "col-lg-" + this.site_item.width.get();
    this.col = new_dom_element({
      parentNode: this.el,
      className: this.width,
      id: this.site_item.id
    });
  }

  return ColView;

})(Process);
// Generated by CoffeeScript 1.4.0
var IFrameView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

IFrameView = (function(_super) {

  __extends(IFrameView, _super);

  function IFrameView(site_item, el) {
    var fa_collapse, fa_expand, panel_title;
    this.site_item = site_item;
    this.el = el;
    IFrameView.__super__.constructor.call(this, this.site_item);
    this.panel_inverse = new_dom_element({
      parentNode: this.el,
      className: "panel panel-inverse"
    });
    this.panel_heading = new_dom_element({
      parentNode: this.panel_inverse,
      className: "panel-heading"
    });
    this.panel_heading_btn = new_dom_element({
      parentNode: this.panel_heading,
      className: "panel-heading-btn"
    });
    this.expand = new_dom_element({
      parentNode: this.panel_heading_btn,
      nodeName: "a",
      className: "btn btn-xs btn-icon btn-circle btn-default",
      href: "javascript:;",
      dataclick: "panel-expand"
    });
    fa_expand = new_dom_element({
      parentNode: this.expand,
      nodeName: "i",
      className: "fa fa-expand"
    });
    this.collapse = new_dom_element({
      parentNode: this.panel_heading_btn,
      nodeName: "a",
      className: "btn btn-xs btn-icon btn-circle btn-warning",
      href: "javascript:;",
      dataclick: "panel-collapse"
    });
    fa_collapse = new_dom_element({
      parentNode: this.collapse,
      nodeName: "i",
      className: "fa fa-minus"
    });
    panel_title = new_dom_element({
      parentNode: this.panel_heading,
      nodeName: "h2",
      className: "panel-title",
      txt: this.site_item.title.get()
    });
    if (this.site_item.format.get() === "page-height") {
      this.window_height = document.body.clientHeight - 130;
      this.panel_content = new_dom_element({
        id: this.site_item.id.get(),
        parentNode: this.panel_inverse,
        className: "embed-responsive",
        style: {
          height: this.window_height + "px"
        }
      });
    } else if (this.site_item.format.get() === "16by9") {
      this.panel_content = new_dom_element({
        id: this.site_item.id.get(),
        parentNode: this.panel_inverse,
        className: "embed-responsive embed-responsive-16by9"
      });
    }
    this.iframe = new_dom_element({
      nodeName: "iframe",
      className: "embed-responsive-item",
      parentNode: this.panel_content,
      src: this.site_item.src
    });
  }

  return IFrameView;

})(Process);
// Generated by CoffeeScript 1.4.0
var HeadingView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

HeadingView = (function(_super) {

  __extends(HeadingView, _super);

  function HeadingView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    HeadingView.__super__.constructor.call(this, this.site_item);
    if (this.site_item.num.get() === 1) {
      this.h1 = new_dom_element({
        nodeName: "h1",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 2) {
      this.h2 = new_dom_element({
        nodeName: "h2",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 3) {
      this.h3 = new_dom_element({
        nodeName: "h3",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 4) {
      this.h4 = new_dom_element({
        nodeName: "h4",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 5) {
      this.h5 = new_dom_element({
        nodeName: "h5",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    } else if (this.site_item.num.get() === 6) {
      this.h6 = new_dom_element({
        nodeName: "h6",
        parentNode: this.el,
        txt: this.site_item.title.get()
      });
    }
  }

  return HeadingView;

})(Process);
// Generated by CoffeeScript 1.4.0
var ImageView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ImageView = (function(_super) {

  __extends(ImageView, _super);

  function ImageView(site_item, el) {
    this.site_item = site_item;
    this.el = el;
    ImageView.__super__.constructor.call(this, this.site_item);
    this.img = new_dom_element({
      nodeName: "img",
      className: "img-responsive",
      parentNode: this.el,
      src: this.site_item.src,
      style: {
        width: this.site_item.width,
        margin: "auto"
      }
    });
  }

  return ImageView;

})(Process);
