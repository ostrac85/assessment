<template>
  <b-card :header="caption">   
       <div> 
          <b-row>   
            <notifications group="foo" position="top center" width="500" height/>
             <b-col sm="8">   
              <b-row>  
                <b-col sm="12" >
                  <b-form-group> 
                     <div class="form-group row" v-if="(!isView && items.id === null) || isView">
                      <label class="col-sm-2 col-form-label"><strong> Description</strong></label>
                      <div class="col-sm-10">   
                        <b-form-input v-model="items.description" size  v-if="isView" type="text" placeholder="Assessment Description"></b-form-input>  
                        <b-form-input v-model="items.description" size  v-if="!isView && items.id === null" type="text" placeholder="Assessment Description"></b-form-input> 
                      </div>   
                    </div>
                     <div class="form-group row" v-if="(!isView && items.id === null) || isView">
                      <label class="col-sm-2 col-form-label"><strong> Level </strong></label>
                      <div class="col-sm-10"> 
                        <!-- <b-form-input v-model="items.userLevel" size  v-if="isView" type="text" placeholder="Assessment Level"></b-form-input>   -->
                        <b-form-select v-model="items.userLevel" :options="options" v-if="isView" placeholder="Assessment Level">                           
                          <template slot="first">
                            <option :value="''" disabled>-- Please select an option --</option>
                          </template>
                        </b-form-select>
                        <b-form-select v-model="items.userLevel" :options="options" v-if="!isView && items.id === null" placeholder="Assessment Level">
                          <template slot="first">
                            <option :value="''" disabled>-- Please select an option --</option>
                          </template>
                        </b-form-select>
                        <!-- <b-form-input v-model="items.userLevel" size  v-if="!isView && items.id === null" type="text" placeholder="Assessment Level"></b-form-input> -->
                      </div>   
                    </div> 
                     <div class="form-group row" v-if="(!isView && items.id === null) || isView">
                      <label class="col-sm-2 col-form-label"><strong> Expiration </strong></label>
                      <div class="col-sm-10">   
                        <datepicker v-model="items.expiryDate" format="yyyy-MM-dd"  size  v-if="!isView && items.id === null" type="text" placeholder="  Expiration Date"></datepicker>
                        <datepicker v-model="items.expiryDate" format="yyyy-MM-dd"  size  v-if="isView" type="text" placeholder="  Expiration Date"></datepicker> 
                        <!-- <b-form-input v-model="items.expiryDate" size  v-if="!isView && items.id === null" type="text" placeholder="Assessment Expiration"></b-form-input> -->
                      </div>   
                    </div>
                    <div v-if="items.id > 0 && !isView" style="margin-left:15px;" >
                      <h2>Description: {{items.description}} </h2>
                        Level: {{items.userLevel}}  <br />
                        Expiration Date: {{formatDate(items.expiryDate)}}  
                    </div>
                  </b-form-group>
                </b-col>
              </b-row> 
              <div class="form-actions"  style="margin:auto; width:50%"> 
                <b-button size="sm" block variant="primary"  type="submit" v-on:click="saveAssesmentDescription" v-if="!isView && items.id === null"> <i class="fa fa-dot-circle-o"></i> Save and Continue </b-button>                        
                <b-button block variant="primary" v-else-if="isView" v-on:click="Update">Update </b-button>   
              </div>                    
              <br />
              <br />
             </b-col>
          </b-row>
        </div> 

        <div class="animated fadeIn" v-if="!isView && items.id !== null">
          <b-row>
            <b-col sm="8">
              <b-card>
                <div slot="header">
                  <strong>Create Questions </strong> <small>Form</small>
                </div>
                <b-row>
                  <b-col sm="12"> 
                    <div v-for="(row, index) in qrows" v-bind:key="index" style="border-bottom: solid 5px #aaa; margin-top:5px; ">
                      <b-form-group>
                        <label for="name"><strong> Question {{index + 1}} </strong></label>  
                          <div class="form-check form-check-inline"> 
                            <button style="margin:10px" type="button" class="button btn-danger" title="Remove question" @click="removeQuestion(index)">
                              <i class="fa fa-minus"></i> Delete
                            </button> 
                          </div>
                          <b-form-input type="text" v-model="row.question" placeholder="Enter question"></b-form-input> 
                         <br/>   
                         <div style="margin-left:30px;" v-for="(qcrow, qindex) in row.qchoices" v-bind:key="qindex">
                            Choice {{qindex+1}} 
                            <b-form-group label-cols="5"> 
                              <div class="form-check form-check-inline">
                               <b-form-input type="text" v-model="qcrow.choice" ></b-form-input>  
                              </div>
                              <div class="form-check form-check-inline"> 
                                <b-form-radio-group :id="`${index}choice`" v-model="qcrow.iscorrect" :plain="true" :options="[{text: 'Correct choice',value: '1'}]" :checked="3">
                                </b-form-radio-group>
                              </div>
                              <div class="form-check form-check-inline"> 
                                <button style="margin:20px" type="button" class="btn btn-danger" title="Remove choice" @click="removeElement(index)">
                                  <i class="fa fa-minus"></i>
                                </button>
                              </div>
                            </b-form-group>   
                            <br /> 
                          </div>  
                         <button  style=" margin-left:30px" block variant="primary"  @click="addChoices(index)">Add Choices</button> 
                      </b-form-group> 
                    </div>
                    <br />
                    <button class="btn btn-primary" @click="addRow"><i class="fa fa-plus"></i> Add Question</button>
                  </b-col>  
                </b-row>
              </b-card>
            </b-col>
            <br /> 
          </b-row>
         <div class="align-middle">
                <button type="button" class="btn btn-primary" v-on:click="submitSave"> <i class="fa fa-upload"> </i> <strong> Save</strong></button>
              </div>
        </div> 
         <div class="animated fadeIn" v-if="items.id !== null && items.questionList != null">
          <b-row>
            <b-col sm="8">
              <b-card>
                <div slot="header">
                  <strong>List of Questions </strong>
                </div>
                <b-row>
                  <b-col sm="12">  
                    <div v-for="(row, index) in items.questionList" v-bind:key="index" style="border-bottom: solid 5px #aaa; margin-top:5px; ">
                      <b-form-group>
                        <label for="name"><strong> Question {{index + 1}} </strong></label>  
                           
                          <b-form-input type="text" v-model="row.question" readonly="readonly"></b-form-input> 
                         <br/> 
                         <div style="margin-left:30px;" v-for="(qcrow, qindex) in row.choices" v-bind:key="qindex">
                            Choice {{qindex+1}}   
                            <b-form-group label-cols="5"> 
                              <div class="form-check form-check-inline">
                               <b-form-input type="text"  readonly="readonly" :value="qcrow.description"></b-form-input>  
                              </div>
                              <div class="form-check form-check-inline">  
                                <i v-if="qcrow.isCorrect == 1" class="fa fa-check-circle-o" aria-hidden="true"> Correct</i>
                              </div> 
                            </b-form-group>   
                            <br /> 
                          </div>  
                      </b-form-group> 
                    </div>
                    <br />
                    
                  </b-col>  
                </b-row>
              </b-card>
            </b-col>
            <br /> 
          </b-row> 
        </div>
  </b-card>
</template>

<script> 
import axios from 'axios'; 
import Datepicker from 'vuejs-datepicker';

const url = 'https://localhost:44308/api';
export default {
  name: "AssessDetail",
  props: {
    caption: {
      type: String,
      default: "Add assessment"
    },
    
  },  
   components: {
  	Datepicker
  },
  data: () => {
    return { 
      items: {
        id: null,
        description: null,
        status: null,
        userLevel: "",
        expiryDate: null,
        createdDate: null
      },
      fields: [
        { key: "id" },
        { key: "description" },
        { key: "status" },
        { key: "createdDate" }
      ],
       options: [ 
          { value: 'Tier 1', text: 'Tier 1' },
          { value: 'Tier 2', text: 'Tier 2' },
          { value: 'Tier 3', text: 'Tier 3' }
        ],
      qrows: [],
      arrStatus : ["Inactive", "Active"],
      isView: false
    };
  },
  methods: {
    getBadge(status) {
      return status === 1
        ? "success" : "danger";
    },
    getRowCount() {
      return this.onFiltered;
    },    
    saveAssesmentDescription() { 
      axios.post(`${url}/Assessments`,  { Description: this.items.description, Status: 1, userLevel: this.items.userLevel, expiryDate:this.items.expiryDate,  createdDate: this.items.createdDate})
      .then(response =>  {
        this.items = response.data;
            this.$notify({
              group: 'foo',
              title: 'Assessment successfully saved.',
              text: ` Description: ${this.items.description} `,
              type: 'success',
              duration: 1000,
              speed: 1000 
            }); 
      })
      .catch(e => {
        this.errors.push(e)
      });         
    },
    addRow: function() {
        let elem = document.createElement('div');
        this.qrows.push({            
            question: "",
            qchoices: []
        });
    },
    addChoices: function(idx) {  
        this.qrows[idx].qchoices.push({  
            choice: ""
        });
    },
    removeElement: function(index) {
        this.qrows[index].qchoices.splice(0, 1);
    },
    
    removeQuestion: function(index) {
        this.qrows.splice(index, 1);
    },
    Update: function() {
       axios.put(`${url}/Assessments/${this.items.id}`,  { id: this.items.id, Description: this.items.description, userLevel: this.items.userLevel, expiryDate:this.items.expiryDate, Status: 1, createdDate: this.items.createdDate} )
        .then(response =>   
        {          
         this.notify('success', 'Assessment successfully updated', ` Description: ${this.items.description} ` ) 
        })
        .catch(e => {
          console.log(e)
        });         
    },
    submitSave: function() {  
      let questions = [];
      for (let key in this.qrows) {
        let row =  this.qrows[key];
        let items = {AssesmentId: this.items.id, Question: row.question}
        if(row.qchoices != null) {
           let arrChoices = [];
            for (let i in row.qchoices) {
              let choice = row.qchoices[i];                
              let choiceItem = {Description: choice.choice, IsCorrect: choice.iscorrect==null ? 0: choice.iscorrect} 
               arrChoices.push(choiceItem);
            }
            items.choices = arrChoices;
        }
        questions.push(items);
      } 
      axios.post(`${url}/SaveAssessmentQuestions`,   questions )
      .then(response =>  { 
         this.items.questionList = response.data;
         this.isView = true;
         this.notify('success', 'Questions successfully saved.', ` Description: ${this.items.description} ` ) 
      })
      .catch(e => { 
      console.log(e)
      });     
    }, 
    formatDate(strDate) {
      let newDate = strDate.replace("T", ' ');
       return newDate.split(" ")[0];
    },
    notify: function(type, title, message) {
          this.$notify({  
               group: 'foo',  
               title: title,  
               text: message,  
               type:  type,  
               duration: 1000,  
               speed: 1000  
             });
       }
  },
   mounted () { 
     if(this.$route.query.id) {
       this.isView = true;
      axios
        .get(`${url}/GetAssessmentQuestions/${this.$route.query.id}`)
        .then(response => (this.items = response.data))
      }
  }
   
   
};
</script>
