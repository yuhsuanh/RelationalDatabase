if ( !window.tabView )
{
  var tabView =
  {};

  tabView.Controller = Class.create();
  tabView.Controller.prototype =
  {
      initialize : function( params )
      {
        this.params = params;
        this.tabs = $$( '#containerTabs li' );
        var activeTab;
        this.tabs.each( function( tab, index )
        {
          tab.tabContent = $( 'contentAreaBlock' + index );
          tab.index = index;
          tab.observe( 'click', this.onTabClicked.bindAsEventListener( this, tab ) );
          tab.observe( 'keydown', this.onKeyDown.bindAsEventListener( this, tab ) );
          this._setTabActive( tab, false );
        }, this );

        (function() { this._setTabActive( this.tabs[this.params.activeTabIndex], true ); }.bind(this).defer());


        if ( !Event.KEY_ENTER )
        {
          Event.KEY_ENTER = 13;
        }
        if ( !Event.KEY_SPACE )
        {
          Event.KEY_SPACE = 32;
        }
      },

      onTabClicked : function( event, tab )
      {
        this.selectTab( tab );
        Event.stop( event );
      },

      selectTab : function( selectedTab )
      {
        this.tabs.each( function( tab )
        {
          this._setTabActive( tab, ( tab == selectedTab ) );
        }, this );

        selectedTab.focus();

        if ( this.params.onTabChanged )
        {
          var func = new Function( "index", "tabId", this.params.onTabChanged );
          func( selectedTab.index, selectedTab.id );
        }
      },


      onKeyDown : function( event, tab )
      {
        var key = event.keyCode || event.which;
        var selTab;
        switch ( key )
        {
          case Event.KEY_RIGHT:
          case Event.KEY_DOWN:
          {
            selTab = tab.next();
            if ( !selTab )
            {
              selTab = this.tabs[ 0 ];
            }
            break;
          }
          case Event.KEY_LEFT:
          case Event.KEY_UP:
          {
            selTab = tab.previous();
            if ( !selTab )
            {
              selTab = this.tabs[ this.tabs.length - 1 ];
            }
            break;
          }
        }
        if ( selTab )
        {
          this.selectTab( selTab );
          Event.stop( event );
        }
      },

      _setTabActive : function( tab, isActive )
      {
        Element[ isActive ? 'show' : 'hide' ]( tab.tabContent );
        Element[ isActive ? 'addClassName' : 'removeClassName' ]( tab, 'active' );
        tab.setAttribute( 'tabindex', isActive ? '0' : '-1' );
        tab.setAttribute( "aria-selected", isActive ? "true" : "false" );
      }

  };

} // end if (!window.tabView)
