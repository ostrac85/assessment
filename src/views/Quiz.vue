<template>
  <b-card :header="caption">  
    <div>  
      <b-row>          
        <notifications group="foo" position="top center" width="500" height/>
        <b-col sm="8">  
          <b-card v-if="isView == false">  
            <div slot="header">  
              <strong>User Login </strong> <small>Form</small>  
              <!-- <strong>User Profile </strong> <small>Form</small>   -->
            </div>  
            <b-row>  
              <b-col sm="12" v-if="user.id === null">
               <b-form-group>  
                  <p v-if="errors.length">   
                    <div class="text-danger"  v-for="error in errors" v-bind:key="error">  {{ error }} 
                      <!-- <li v-for="error in errors" v-bind:key="error">{{ error }}</li>   -->
                    </div>  
                  </p>  
                  <div class="form-group row">
                      <label class="col-sm-2 col-form-label"><strong> UserName</strong></label>
                      <div class="col-sm-10">  
                        <b-form-input type="text" v-model="user.userName" placeholder="Username"></b-form-input>   
                      </div>  
                  </div> 
                  <div class="form-group row"> 
                      <label class="col-sm-2 col-form-label"><strong> Password</strong></label>
                      <div class="col-sm-10">  
                        <b-form-input type="password" v-model="user.userPassword" placeholder="Password"></b-form-input>   
                      </div>  
                  </div> 
               </b-form-group>
              </b-col> 
              <b-col sm="12" v-else>
                 <b-form-group>  
                   <div class="form-group row">  
                     <div class="col-sm-10">  
                          <h2>Hello {{user.firstName}} {{user.lastName}}</h2>
                     </div>
                     
                   </div>
                 </b-form-group>
              </b-col> 
              <!-- <b-col sm="12">  
                <b-form-group>  
                  <p v-if="errors.length">  
                    <b>Please correct the following error(s):</b>  
                    <ul class="text-danger">  
                      <li v-for="error in errors" v-bind:key="error">{{ error }}</li>  
                    </ul>  
                  </p>  
                  <div class="form-group row">
                      <label class="col-sm-2 col-form-label"><strong> First Name</strong></label>
                      <div class="col-sm-10">  
                      <b-form-input type="text" v-model="user.firstName" placeholder="First Name" v-if="user.id === null"></b-form-input>  
                      <b-form-input type="text" v-model="user.firstName" placeholder="First Name" readonly="" v-if="user.id !== null"></b-form-input>  
                    </div>  
                  </div>  
                  <div class="form-group row">  
                    <label class="col-sm-2 col-form-label"><strong> Last Name</strong></label>  
                    <div class="col-sm-10">  
                      <b-form-input type="text" v-model="user.lastName" placeholder="Last Name" v-if="user.id === null"></b-form-input>  
                      <b-form-input type="text" v-model="user.lastName" placeholder="Last Name" readonly="" v-if="user.id !== null"></b-form-input>  
                    </div>  
                  </div>   
                  <div class="form-group row">  
                    <label class="col-sm-2 col-form-label"><strong> Email</strong></label>  
                    <div class="col-sm-10">  
                      <b-form-input type="text" v-model="user.email" placeholder="Email" v-if="user.id === null"></b-form-input>  
                      <b-form-input type="text" v-model="user.email" placeholder="Email" readonly="" v-if="user.id !== null"></b-form-input>  
                    </div>  
                  </div>  
                  <div class="form-group row">  
                    <label class="col-sm-2 col-form-label"><strong>Phone </strong></label>  
                    <div class="col-sm-10">  
                      <b-form-input type="number" v-model="user.phone" placeholder="Phone number" v-if="user.id === null"></b-form-input>  
                      <b-form-input type="text" v-model="user.phone" placeholder="Phone number" readonly="" v-if="user.id !== null"></b-form-input>  
                    </div>  
                  </div>  
                </b-form-group>  
                <br />  
              </b-col>   -->
              <br/>  
              <div class="form-actions" style="margin:auto"  v-if="user.id === null">  
                <!-- <b-button size="sm" block variant="primary" type="submit" v-on:click="saveUser" v-if="user.id === null">  
                  <i class="fa fa-dot-circle-o"></i> Save and Continue 
                </b-button>       -->
                <b-button size="sm" block variant="primary" type="submit" v-on:click="LoginUser">  
                  <i class="fa fa-dot-circle-o"></i> Login
                </b-button> 
              </div>  
              <div class="form-actions" style="margin:auto;" v-if="user.id !== null">  
                <b-button size="sm" block variant="primary" type="submit" v-on:click="TakeExam" v-if="assessmentAnswered === false && assessmentId">  
                  <i class="fa fa-dot-circle-o"></i> Take Exam
                </b-button>   
                <div class="alert alert-info" role="alert" v-if="assessmentAnswered === true">Hi <strong>{{user.firstName}}!</strong> You already answered this assessment. </div>
                <div class="alert alert-warning" role="alert" v-else-if="!assessmentId">Hi <strong>{{user.firstName}}!</strong> You have not selected an assessment. </div>
              </div>
            </b-row>  
          </b-card>  
        </b-col>  
        <br />  
      </b-row>  
    </div>  
    <br />  
    <div v-if="isView && user.id !== null">  
      <h1> {{items.description}} </h1>  
      <h2>{{user.firstName}} {{user.lastName}}</h2>  
    </div>  
    <div class="animated fadeIn" v-if="user.id !== null && isView">  
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
                    <input type="hidden" v-model="row.id">
                    <input type="hidden" v-model="row.answer">    
                    <b-form-input type="text" v-model="row.question" readonly="readonly"></b-form-input>  
                    <br/>  
                    <div class="form-check form-check-inline" v-if="answer.length != 0"> 
                          <i v-if="answer[index].correctAnswer === row.answer && answer[index].userAnswer !== null" class="fa fa-check-circle-o" aria-hidden="true" style="color:green"> Correct </i>
                           
                          <i v-else class="fa fa-close" style="color:red">Wrong</i> 
                    </div> 
                    <div style="margin-left:30px;" v-for="(qcrow, qindex) in row.choices" v-bind:key="qindex">  
                      <b-form-group label-cols="5">  
                        <div class="form-check form-check-inline"  v-if="answer.length === 0">  
                          <input type="radio" :id="`${index}choice`" :name="`${index}choice`"  v-on:click="row.answer = qcrow.id">   
                        </div>
                        <div class="form-check form-check-inline"  v-if="answer.length > 0">  
                          <input type="radio" :id="`${index}choice`" :name="`${index}choice`" disabled>   
                        </div>
                        <div class="form-check form-check-inline">  
                          <b-form-input type="text" readonly="readonly" :value="qcrow.description"></b-form-input>  
                        </div>  
                      </b-form-group>  
                      <br /> 
                    </div> 
                  </b-form-group>
                </div> 
              </b-col>               
            </b-row>            
          </b-card>
          <div class="form-actions" style="margin:auto">
            <b-button size="sm" v-if="answer.length == 0" block variant="primary" type="submit" v-on:click="SubmitAnswers" > <strong> Submit </strong></b-button>
            <div v-if="answer.length > 0" class="alert alert-success" role="alert">{{ score }}</div>
          </div>
        </b-col>
      </b-row>
    </div>
  </b-card>
</template>

<script>
   import axios from 'axios';
  
   const url = 'https://localhost:44308/api';
  
   export default {  
     name: "Quiz",  
     props: {  
       caption: {  
         type: String,  
         default: "Test Page"  
       },
     },
  
     data: () => {  
       return {  
         items: {  
           id: null,  
           description: null,  
           status: null,  
           createdDate: null  
         },
  
         user: {  
           id: null,  
           userName: "",  
           userPassword: "",  
           firstName: "",  
           lastName: "",  
           email: "",  
           phone: null  
         },
  
         fields: [{  
             key: "id"  
           },  
           {  
             key: "description"  
           },  
           {  
             key: "status"  
           },  
           {  
             key: "createdDate"  
           }  
         ],
  
         qrows: [],  
         answer:[],
         errors: [],
         assessmentAnswered: false,
         assessmentId: false,
         score: "",
         arrStatus: ["Inactive", "Active"],  
         isView: false  
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
         let newDate = new Date(strDate)  
         return newDate.toDateString();  
       },
  
       valideEmail: function(email) {  
         var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
         return re.test(String(email).toLowerCase());  
       },
  
       saveUser() {  
         this.errors = []  
         if (!this.user.firstName) {  
           this.errors.push("First Name invalid required.");  
           return;  
         }
  
         if (!this.user.lastName) {  
           this.errors.push("Last Name is required.");  
           return;  
         }
  
         if (!this.valideEmail(this.user.email)) {  
           this.errors.push("Email is required.");  
           return;  
         }
         if (! this.user.phone) {  
           this.errors.push("Phone is required.");  
           return;  
         }
  
         axios.post(`${url}/AssessmentUsers`, this.user)
             .then(response => {  
             this.user = response.data;  
           })  
           .catch(e => {  
             this.errors.push(e)  
           });  
       },
  
       TakeExam: function() {  
         this.isView = true;   
       },
  
       Update: function() {  
         axios.put(`${url}/Assessments/${this.items.id}`, {  
             id: this.items.id,  
             Description: this.items.description,  
             Status: 1,  
             createdDate: this.items.createdDate  
           })  
           .then(response => {             
              this.notify('success',  'Assessment successfully updated',  ` Description: ${this.items.description} `) 
           })  
           .catch(e => {  
             console.log(e)  
           });  
       },
  
       submitSave: function() {  
         let questions = [];  
         for (let key in this.qrows) {  
           let row = this.qrows[key];  
           let items = {  
             AssesmentId: this.items.id,  
             Question: row.question  
           }
  
           if (row.qchoices != null) {  
             let arrChoices = [];  
             for (let i in row.qchoices) {
  
               let choice = row.qchoices[i];  
               let choiceItem = {  
                 Description: choice.choice
               }  
               arrChoices.push(choiceItem);  
             }  
             items.choices = arrChoices;  
           }  
           questions.push(items);  
         }
  
         axios.post(`${url}/SaveAssessmentQuestions`, questions)
           .then(response => {  
              this.items.questionList = response.data;
              this.notify('success',  'Questions successfully saved.',  ` Description: ${this.items.description} `)  
           })  
           .catch(e => { 
             console.log(e)  
           });  
       },
       SubmitAnswers: function(){ 
         let data = [];
          for (let i in this.items.questionList) {
                
                 let obj = { 
                  userId: this.user.id,
                  assessmentId: this.$route.query.id,
                  questionId: this.items.questionList[i].id,
                  userAnswer: this.items.questionList[i].answer,
                  correctAnswer: null
                };
                data.push(obj);
          }
           axios.post(`${url}/SaveUserAnswers`, data)
           .then(response => {  
              this.answer = response.data;  
              if(this.answer.length > 0) {
                let totalScore = 0;
                 for(let i in this.answer) {
                  this.answer[i].userAnswer == this.answer[i].correctAnswer ? totalScore++ : totalScore;
                 } 
                let percentage = Math.round((totalScore/this.answer.length) * 100);
                this.score = `Total score: ${percentage}% or (${totalScore} out of ${this.answer.length}) correct answers.` 
                this.notify('success',  'Answers successfully saved.',  `${this.score}`)  
              }
           })  
           .catch(e => { 
             console.log(e)  
           });        
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
       },
       LoginUser: function() {  
         this.errors = []
         if(!this.user.userName || !this.user.userPassword) {
           this.errors.push("Incorrect login.");
           return;
         }
          axios.post(`${url}/Login`, {userName: this.user.userName, userPassword: this.user.userPassword})
           .then(response => {   
             if(!response.data) {
               this.errors.push("Incorrect login.");
               return;
             }
             this.user = response.data;  
             if(this.user.assessmentAnswers.length > 0) {
               for(let i in this.user.assessmentAnswers) {
                 let assessed =  this.user.assessmentAnswers[i] == this.assessmentId;
                 if(assessed) {
                   this.assessmentAnswered = assessed;
                   return;
                 }
               } 
             }
           }) 
           .catch(e => {  
            this.errors.push("Incorrect login.");
             console.log(e)  
           });  
       }
     },
  
     mounted() { 
       if (this.$route.query.id) {
       this.assessmentId = this.$route.query.id;
         axios
           .get(`${url}/GetTestQuestions/${this.$route.query.id}`)
           .then(response => (this.items = response.data))
       }
     } 
   };
</script>
