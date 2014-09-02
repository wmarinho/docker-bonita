/*
Usage
<script>

$('#id input').gsatApi({
	"endpoint" : "js/usuario.json",
	"field" : "displayName",
	"type" : "suggestion",
	"query" : "",
	"template" : "<p><strong>{{displayName}} </strong></p>",
	"onSelected" : function (obj, datum) {
	 console.log(obj);
    console.log(datum);
	$("#ano input").val(datum.department);
 }
});

</script>
*/
;(function ( $, window, document, undefined ) {

		// Create the defaults once
		var pluginName = "gsatApi",
				defaults = {
				endpoint: "scripts/service",
				query: "",
				template: "",
				type: "suggestion"
		};

		// The actual plugin constructor
		function Plugin ( element, options ) {
				this.element = element;

				this.settings = $.extend( {}, defaults, options );
				this._defaults = defaults;
				this._name = pluginName;
				this.data = [];
				this.init();
		}

		$.extend(Plugin.prototype, {
				init: function () {
						
						if ( this.settings.endpoint !== undefined) {
							this.connectEndpoint();
						}
						
				},
				connectEndpoint: function () {					
					
					if ( this.settings.type !== undefined && this.settings.type === "suggestion" ) {
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
						ttl: 10000,
						prefetch: {
							url: this.settings.endpoint,
							filter: function (data) {
								var result = [];
									if ( data.metadata !== undefined )  {
										var arrCol = [];
										for (var i in data.metadata) {
											arrCol[i] = data.metadata[i].colName;
										}									
										for (var j in data.resultset) {		
											var arr = {};
											for (var i in data.resultset[j]) {
												arr[arrCol[i]] = data.resultset[j][i];
											}
											result.push(arr);
										}
										this.data = result;									
									} else this.data = data;									
								return this.data;
							}
						},
						 dataType: 'jsonp',
						remote: this.settings.endpoint+'?q=%QUERY'
					});
					
					service.initialize();
					
					//console.log(service);
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
					})
					.on('typeahead:selected', onSelected)
					.on('typeahead:autocompleted', onSelected)
					.on('typeahead:cursorchanged', onSelected)
					.on('typeahead:opened',function(){
						$('.tt-dropdown-menu')
							.css('width',$(this).width()*1.1 + 'px');
					});
		
		
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