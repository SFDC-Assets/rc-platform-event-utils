/**
 * Created by ryan.cox on 7/28/21.
 */

global class rcCountCache_GetDayCount {

    @InvocableMethod(label='rcCountCache - Get Day Count')
    global static void getDayCount(List<Date> cacheDateList) {

        List<rcCDC_Count__c> cdcList = new List<rcCDC_Count__c>();

        for (Date cacheDate : cacheDateList) {

            System.debug('rcCountCache_GetDayCount > getDayCount: ' + cacheDate);

            String cacheDateString = getDateString(cacheDate);
            Map<String, Integer> countMap = rcCountCache.getCounts();
            for (String key : countMap.keySet()) {
                if (key.startsWith(cacheDateString)) {
                    rcCDC_Count__c entry = new rcCDC_Count__c();
                    entry.Name = key;
                    List<String> toks = key.split(cacheDateString);
                    entry.Object_Name__c = toks[1];
                    entry.Date__c = cacheDate;
                    entry.Date_String__c = cacheDateString;
                    entry.Count__c = (Integer) countMap.get(key);
                    //System.debug('rcCountCache_GetDayCount > entry: ' + entry);
                    cdcList.add(entry);
                }
            }
            if (cdcList.size() > 0) {
                insert cdcList;
            }

        } // end for


    }

    private static String getDateString(Date cacheDate) {
        Datetime dt = DateTime.newInstance(cacheDate.year(), cacheDate.month(), cacheDate.day());
        return dt.format('ddMMyyyy');
    }
}