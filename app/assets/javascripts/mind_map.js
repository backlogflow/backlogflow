$(document).ready(function(){
  //Create a new ST instance  
  var st = new $jit.ST({
      orientation: 'left',
      siblingOffset: 10,
      //id of viz container element  
      injectInto: 'mind_map_canvas',  
      //set duration for the animation  
      duration: 500,  
      //set animation transition type  
      transition: $jit.Trans.Quart.easeInOut,  
      //set distance between node and its children  
      levelDistance: 80,
      //enable panning  
      Navigation: {
        enable:true,  
        panning:true,
        // zooming:30
      },  
      //set node and edge styles  
      //set overridable=true for styling individual  
      //nodes or edges  
      Node: {
          autoHeight:true,
          autoWidth:false,
          width: 120,
          type: 'rectangle',
          color: '#333',  
          overridable: true
      },
      
      Label:{
        autoHeight:true,
        size:14
      },

      Edge: {
          type: 'bezier',  
          overridable: true
      },

      //This method is called on DOM label creation.  
      //Use this method to add event handlers and styles to  
      //your node.  
      onCreateLabel: function(label, node){
          label.id = node.id;
          label.innerHTML = node.name;
          label.onclick = function(){
              st.onClick(node.id);
          };
          //set label styles  
          var style = label.style;
          style.width = 120 + 'px';
          style.height = 35+'px';
          style.cursor = 'pointer';
          style.color = '#333';
          style.textAlign= 'center';
      },  

      //This method is called right before plotting  
      //a node. It's useful for changing an individual node  
      //style properties before plotting it.  
      //The data properties prefixed with a dollar  
      //sign will override the global node style properties.  
      onBeforePlotNode: function(node){
          //add some color to the nodes in the path between the  
          //root node and the selected node.  
          if (node.selected) {
              node.data.$color = "#fc7";
          } 
          else {
              delete node.data.$color;
              //if the node belongs to the last plotted level  
              if(!node.anySubnode("exist")) {
                  //count children number  
                  var count = 0;
                  node.eachSubnode(function(n) { count++; });
                  //assign a node color based on  
                  //how many children it has  
                  // node.data.$color = ['#999', '#a99', '#b99', '#c99', '#d99', '#e99', '#f99'][count/2];
                  node.data.$color = '#ccc'
              } 
          } 
      },  

      //This method is called right before plotting  
      //an edge. It's useful for changing an individual edge  
      //style properties before plotting it.  
      //Edge data proprties prefixed with a dollar sign will  
      //override the Edge global style properties.  
      onBeforePlotLine: function(adj){
          if (adj.nodeFrom.selected && adj.nodeTo.selected) { 
              adj.data.$color = "#eed";
              adj.data.$lineWidth = 3;
          }
          else {
              delete adj.data.$color;
              delete adj.data.$lineWidth;
          }
      }
  });

  var projectId = $("#project").attr("class");
  var url = '/project/'+ projectId + '/stories.json';
  $.get('/project/'+ projectId +'/stories.json', function(json){
    //load json data  
    st.loadJSON(json);
    //compute node positions and layout  
    st.compute();
    //optional: make a translation of the tree  
    st.geom.translate(new $jit.Complex(-200, 0), "current");
    //emulate a click on the root node.
    st.onClick(st.root);
  });
});