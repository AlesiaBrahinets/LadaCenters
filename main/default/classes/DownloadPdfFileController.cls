public class DownloadPdfFileController {
    public List<PricebookEntry> PDFData {get; set;} 
    
    public DownloadPdfFileController(){
        PDFData = [select id,UnitPrice, Product2.Name,  Product2.Complectation__c from PricebookEntry where Pricebook2.Name like 'Lada Granta%'];
    }
    
    public PageReference downloadPDF(){
        System.PageReference pageRef = new System.PageReference('/apex/PDFGenerator');
    
        //ensure pdf downloads and is assigned with defined name
        pageRef.getHeaders().put('content-disposition', 'attachment; filename=TestPDF.pdf');
     
        return pageRef;
    }

}