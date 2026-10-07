
function normalizePort(portVal: string){
    const port = parseInt(portVal , 10);
    
    if (!isNaN(port) && port >= 0 ) return port;
    return 3000;
}