## Total connectivity (similar to PRANA)
thetahats = function(asso.matinput) {
        # if(class(asso.matinput)[1] == "network") {
        #         asso.matinput <- get_association_matrix(asso.matinput)
        # }
        results = vector()
        for(j in 1:ncol(asso.matinput)) {
                results[j] = sum(asso.matinput[j, -j])
        }
        return(results)
}


