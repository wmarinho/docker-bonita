
;(function ( $, window, document, undefined ) {

		// Create the defaults once
		var pluginName = "gsatApi",
				defaults = {
				endpoint: "scripts/service",
				type: "suggestion"
		};

		// The actual plugin constructor
		function Plugin ( element, options ) {
				this.element = element;

				this.settings = $.extend( {}, defaults, options );
				this._defaults = defaults;
				this._name = pluginName;
				this.init();
		}

		$.extend(Plugin.prototype, {
				init: function () {
						
						if ( this.settings.endpoint !== undefined) {
							this.connectEndpoint();
						}
						
				},
				connectEndpoint: function () {						
						if ( this.settings.type !== "undefined" && this.settings.type === "suggestion" ) {
							this.getSuggetion();
						}
						
				},
				getSuggetion: function () {	
					var key = this.settings.field;
					var name = this.settings.name;
					var template = this.settings.template || '<p><strong>{{'+key+'}}</strong></p>';
					var onSelected = typeof(this.settings.onSelected) === 'function' ? this.settings.onSelected : null;
					
					var service = new Bloodhound({
						datumTokenizer: Bloodhound.tokenizers.obj.whitespace(key),
						queryTokenizer: Bloodhound.tokenizers.whitespace,
						prefetch: this.settings.endpoint,						
						remote: this.settings.endpoint+'?q=%QUERY'
					});
					
					service.initialize();
							
					$(this.element).typeahead({
						minLength: 1
					},	
					{
					  name: 'endpoint',
					  displayKey: key,
					  
					   source: service.ttAdapter(),
						templates: {
							empty: [
							'<div class="empty-message">',
							'Item não encontrado.',
							'</div>'
							].join('\n'),
							suggestion: Handlebars.compile(template)
						}
					}).on('typeahead:selected', onSelected);		
		
				}
		});

		// A really lightweight plugin wrapper around the constructor,
		// preventing against multiple instantiations
		$.fn[ pluginName ] = function ( options ) {
				this.each(function() {
						if ( !$.data( this, "plugin_" + pluginName ) ) {
								$.data( this, "plugin_" + pluginName, new Plugin( this, options ) );
						}
				});

				// chain jQuery functions
				return this;
		};

})( jQuery, window, document );