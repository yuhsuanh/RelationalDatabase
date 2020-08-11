if ( !window.bb_dialogs )
{
  var bb_dialogs =
  {
      /**
       * Open a modal confirmation dialog.  When any of the provided buttons are clicked, the dialog will be closed.
       * <pre>
       * options: 
       *   title: the title 
       *   contentId: id of the div's content to use for dialog dom (this is used preferentially over the 'html' option)
       *   html: html to display
       *   buttons: array of buttons with each element containing 
       *     {text: text of button, action: action on click}
       *   onclose: function to call when dialog is closed (regardless of button choice)
       * </pre>
       */
      bb_confirm : function( options )
      {
        var $j = jQuery.noConflict();

        var theDiv = jQuery( '<div/>',
        {
          html : options.contentId ? jQuery( '#' + options.contentId ).html() : options.html
        } );
        // Don't have to actually add that div to the DOM - let .dialog do that.

        var theDialog = $j( theDiv );
        theDialog.dialog(
        {
            title : options.title,
            modal : true,
            dialogClass: 'bb-dialog',
            close : function( event, ui )
            {
              if ( options.onClose )
              {
                options.onClose();
              }
              // Remove the dialog from the DOM - otherwise it builds up with each dialog we create
              this.parentElement.remove();
            }
        } );

        for ( var idx in options.buttons )
        {
          var theButton = options.buttons[ idx ];
          var extras =
          {
              theDialog : theDialog,
              action : theButton.action
          };
          theButton.action = null; // Blond moment, but I can't figure out why jquery actually calls this function when
          // adding the buttons to the dialog below
          theButton.click = bb_dialogs.bb_confirm_click.bind( extras );
        }

        theDialog.dialog( "option", "buttons", options.buttons );
      },

      bb_confirm_click : function()
      {
        if (this.action) 
        {
          this.action();
        }
        this.theDialog.dialog( "close" );
      }
  };
}