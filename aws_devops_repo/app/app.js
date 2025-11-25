const express=require('express');
const app=express();
app.get('/',(req,res)=>res.send('AWS DevOps Project Deployed Successfully with CodePipeline + Terraform!'));
app.listen(3000);