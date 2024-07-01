const cds = require('@sap/cds')
const {employees} = cds.entities("anubhav.db.master");

module.exports = function(srv){
 
    //DPX extension class in ABAp
    srv.on('hello', function(req,res){
        let name = req.data.name;
        return "Hello " + name;
    });

    

     srv.on('READ','ReadEmployeeSrv', async(req,res) => {
         let result = [];
       
        //Example 1: return hardcoded data
        //result.push({"ID":"DUMMY","nameFirst": "Christiano",
        //                 "nameLast":"Ronadlo"});
 
 
        //Exmaple 2: get top 10 records
        //result = cds.tx(req).run(SELECT.from(employees).limit(10));
        //return result;
        //Exmaple 3: get record by where
          result = await cds.tx(req).run(SELECT.from(employees).limit(10).where(
            {
                 salaryAmount: {'>=' : 90000}
            }));
 
        let totalAmount = 0;
        console.log("PP_BD Result ="+ result);
         for(let index = 0; index < result.length; index++){
             totalAmount += parseInt(result[index].salaryAmount);
         }

        result.splice(0,0,{"ID":"Total Amount", "salaryAmount": totalAmount})
        return result;
 
     });
 
}