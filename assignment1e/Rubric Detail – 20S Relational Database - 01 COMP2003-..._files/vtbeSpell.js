var vtbeSpell = {};

vtbeSpell.currentFieldSpellCheck = null;

vtbeSpell.baseURL = null;
vtbeSpell.lightboxTitle = null;

vtbeSpell.displaySpellCheck = function ( myField )
{
  if ( !vtbeSpell.baseURL )
  {
    TinyMceDWRFacade.getBaseURL( {
         async: false,
         callback: function( baseURL )
         {
            vtbeSpell.baseURL  = baseURL;
         }
      }
    );
  }

  if ( !vtbeSpell.lightboxTitle )
  {
    TinyMceDWRFacade.getLocalizedString( "lightbox.spellcheck.title", {
         async: false,
         callback: function( baseURL )
         {
            vtbeSpell.lightboxTitle  = baseURL;
         }
      }
    );
  }

  var showLightbox = vtbeUtil.lightBox (myField.value,vtbeSpell.lightboxTitle, vtbeSpell.baseURL + "execute/tinymce/lightbox","vtbeSpell.submitSpellCheck", myField.id, true, true);
  if ( showLightbox )
  {
    var wrapper = tinyMceWrapper.getEditor( "contenttext" ); //The lightbox always has editor with name contenttext
    var tinyMceEditor = wrapper.getTinyMceEditor();
    tinyMceEditor.undoManager.clear(); //Remove all the bookmarks
    wrapper.replaceHTML( myField.value );
    //Fix LRN-43074, force to do character count for all browsers
    tinyMCE.execInstanceCommand( 'contenttext', 'mceUpdateCharacterCount');
    tinyMCE.execInstanceCommand( 'contenttext', 'mceSpellCheck' );
  }
};

vtbeSpell.submitSpellCheck = function ( modifiedContent, myFieldId )
{
  vtbeSpell.currentFieldSpellCheck.value =  modifiedContent;
};



/**
 * This is method is called when the spell check is to be done for the textarea.
 *
 * @param myField   The textarea that needs the spell check
 * @return
 */
function spellcheckField( myField )
{
  vtbeSpell.currentFieldSpellCheck  = myField;
  vtbeSpell.displaySpellCheck ( myField );
}

