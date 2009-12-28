<cfcomponent output="false" implements="IDocument" hint="Default implementation of IDocument and used by the Mongo class to generate a document.">

<cfset this.model =  structNew() />
<cfset variables.mongo = createObject('component', 'MongoDB') />


<cffunction name="init" hint="Constructor. Creates an instance of a MongoDocument.">
 	<cfargument name="collection_name" type="string" required="true" hint="The name of the collection to which this document is bound." />
    <cfargument name="_mongo" type="any" required="false" default="#variables.mongo#" hint="The instance of the Mongo wrapper to which the document is bound." />
    <cfset variables.mongo.collection(collection_name) />
	<cfset variables.mongo = _mongo />
	<cfreturn this /> 
</cffunction>


<cffunction name="setCollection">
</cffunction>


<cffunction name="set" hint="Sets a  property for the Document" returntype="void">
  <cfargument name="property" type="String" />
  <cfargument name="value" type="Any" />
  <cfset structInsert(this.model, arguments.property, arguments.value, true) />
</cffunction>


<cffunction name="get" hint="Fetches the value of the given property. Returns null if not found." returntype="Any">
  <cfargument name="property" />
  <cfset var ret_val = javacast('null', '') />
  <cftry>
	<cfset ret_val = this.model[arguments.property] />
	<cfcatch type="Expression">
	 <!--- want to return null --->
	</cfcatch>
	</cftry>
  <cfreturn ret_val />
</cffunction>

<cffunction name="remove" returntype="void" hint="Removes a property form a Document. **NOT IMPLEMENTED**">
  <cfargument name="property" hint="Removes the given property if it exists." />
  <cfthrow type="NotImplementedException" message="To Do.">
</cffunction>



<cffunction name="save" returntype="String">
	<cfreturn mongo.put(this.model) />
</cffunction>


<cffunction name="delete" returntype="void" hint="Deletes this Document from the Collection">
  <cfset mongo.deleteById(this.model['_id']) />
</cffunction>


<cffunction name="update"  hint="Performs in-place update of the the value for 'property'. NOT IMPLEMENTED">
 <cfargument name="property">
 <cfargument name="value">
 <cfthrow type="NotImplementedException" message="To Do.">
</cffunction>


<cffunction name="validate" hint="Should be called before save() to perform any required validation. NOT IMPLEMENTED" returntype="void">
  <cfthrow type="NotImplementedException" message="To Do.">
</cffunction>

</cfcomponent>