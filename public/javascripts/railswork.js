var RailsWork = {
  
  Common: {
    
    AddLoadEvent: function(func) {
      var oldonload = window.onload;
        if (typeof window.onload != 'function') {
          window.onload = func;
        } else {
          window.onload = function() {
            if (oldonload) {
              oldonload();
            }
            func();
          }
        }
    },
    
    ToggleSearchField: function(field) {
      text = "enter search terms..."
      if (field.value == text) {
        field.className = "active"
        field.value = ""
      } else if (field.value == "") {
        field.className = "inactive"
        field.value = text
      } 
    },
    
    SetupSearchField: function() {
      
      field = $('search_input');
      field.className = "inactive";
      field.value = "enter search terms...";
      field.onfocus = function() {RailsWork.Common.ToggleSearchField(this)};
      field.onblur = function() {RailsWork.Common.ToggleSearchField(this)}
    },
    
    SetupExternalLinks: function() { 
      if (!document.getElementsByTagName) return;
       var anchors = document.getElementsByTagName("a");
       for (var a=0; a<anchors.length; a++) {
         re = new RegExp("external");
         rel = anchors[a].getAttribute("rel");
         if (anchors[a].getAttribute("href") && rel && rel.match(re)) anchors[a].target = "_blank";
       }
    }
        
  },
  
  Jobs: {
    
    ActivateSubNav: function(category) {
      
      categories = $('subnav_' + category).siblings();
      for(c=0; c < categories.length; c++) {
        categories[c].removeClassName('active');
      }
      $('subnav_' + category).addClassName('active');
      
    }
    
  }
  
  
  
}



RailsWork.Common.AddLoadEvent(RailsWork.Common.SetupSearchField);
RailsWork.Common.AddLoadEvent(RailsWork.Common.SetupExternalLinks);