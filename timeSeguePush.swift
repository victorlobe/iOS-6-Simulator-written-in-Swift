//destination
    
    var emptyString = String()
   
    override func viewDidLoad() {


//source

    override func viewDidLoad() {
        
        Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
        
        }
        
        
        
        
        
            func timeToMoveOn() {
        self.performSegue(withIdentifier: "unlock", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "unlock") {
            
            
            
            print("Segue Performed")
            
        }
        
    }