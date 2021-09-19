# Catlog
Catlog


Alamofire (A network Libray, best part of it is to auto-setup the codable struct) could make things much easier and save an hour of work. But as this is a coding changeling, I assume I should not use 3rd party library, plus it makes it much harder to install for your device testing.

The page navigation panel (size / paginating) isn't a commonly used view for iOS, and there isn't a native one. I have to make new SizePanelView and PagePanelView from the scratch. The UIPickerView could be a substitute, but it's mostly used in some other cases for better user experience reasons.

Known Issues:

1 - updated max page function is not implemented. I didn't find the API to show current max result on the site, a walk round would be testing the maxReusltCount by:    

    - use userDefaults to save the last known maxReusltCount locally    
    - listing 100 items on lastKnowPage = lastMaxResultCount / 100    
    - if responseData.count < lastMaxResult % 100, then update maxResultCount (server deleted some data)    
    - if reponseData == 0, then check page -1 (server deleted a lot of data)    
    - if responseData.count == 100, then check page + 1    
    - if responseData.count < 100 && > 0, then we know the max result on site.     
    - this function can be called on a background thread on each new launch or when user reaching the last page

2 - the view was set as universal for all iOS devices in the vertical mode, but the horizontal mode is not set

3 - the server only supports 100 items per API request, listing more is possiable but not being implemented  
Thanks for your time for the interview and reading through the code.



Best,Dan
