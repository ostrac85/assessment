<template>
  <b-card :header="caption">
    <div>
      <b-navbar type="light" variant="light">
        <b-nav-form>
          <b-form-input class="mr-sm-2" v-model="description" type="text" placeholder="Description"></b-form-input>
        </b-nav-form>   
       
      </b-navbar>
    </div>
    <b-table :hover="hover" :striped="striped" :bordered="bordered" :small="small" :fixed="fixed" responsive="sm" :items="filtereditems" :fields="fields" :current-page="currentPage" :per-page="perPage">
      <!-- <template slot="description" slot-scope="data">
            <router-link :to="{ path: 'assessdetail?id='+data.item.id}" replace> {{data.item.description}} </router-link>
    </template> -->

    <template slot="status" slot-scope="data">
      <b-badge :variant="getBadge(data.item.status)">
        {{arrStatus[data.item.status]}}</b-badge>
    </template>
    <template slot="expiryDate" slot-scope="data"> 
        {{formatDate(data.item.expiryDate)}} 
    </template> 
     <template slot="score" slot-scope="data">
         {{data.item.score}} point(s) or 
        {{getScore(data.item.score, data.item.items)}}%  
         
         
    </template>   
    
    <template slot="name" slot-scope="data">
        {{ data.item.firstName + " "+ data.item.lastName}}
      </template>
      </b-table>
      <nav>
        <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" prev-text="Prev" next-text="Next" hide-goto-end-buttons/>
      </nav>
  </b-card>
</template>

<script>
   import axios from 'axios';
   export default {
     name: "assessment_result",
     props: {
       caption: {
         type: String,
         default: "Assessment Results"
       },
       hover: {
         type: Boolean,
         default: false
       },
       striped: {
         type: Boolean,
         default: true
       },
       bordered: {
         type: Boolean,
         default: true
       },
       small: {
         type: Boolean,
         default: false
       },
       fixed: {
         type: Boolean,
         default: false
       }
     },
     data: () => {
       return {
         items: [], 
         fields: [ 
           {
             key: "name"
           }, 
           {
             key: "description"
           },
          
           {
             key: "items"
           },
           {
             key: "score"
           },
         ],
         currentPage: 1,
         perPage: 10,
         totalRows: 0,
         filter: "",
         description: "",
         arrStatus: ["Inactive", "Active"]
       };
     },
     methods: {
       getBadge(status) {
         return status === 1 ?
           "success" : "danger";
       },
       getRowCount() {
         return this.onFiltered;
       },
       formatDate(strDate) {
         return strDate.replace("T", ' ');
       },
       getScore: function(score, items){ 
           return Math.round( ((score/items) * 100) * 100 ) / 100;
       }
     },
     computed: {
       filtereditems() {
         let items = this.items;
         items = items.filter(data => {
           return data.description
             .toLowerCase()
             .includes(this.description.toLowerCase());
         });
         this.totalRows = items.length;
  
         return items;
       }
  
     },
     mounted() {
       axios
         .get('https://localhost:44308/api/GetAssessmentUsersList')
         .then(response => (this.items = response.data))
     }
   };
</script>
