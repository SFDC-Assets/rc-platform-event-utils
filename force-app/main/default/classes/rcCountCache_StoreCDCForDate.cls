global class rcCountCache_StoreCDCForDate {

    @InvocableMethod(label='rcCountCache - Store CDC For Date')
    global static void storeCDCCount(List<Date> cacheDateList) {

        List<rcCDC_Count__c> cdcList = new List<rcCDC_Count__c>();

        for (Date cacheDate : cacheDateList) {
            System.debug('rcCountCache_StoreCDCForDate > cacheDate: ' + cacheDate);
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
                    cdcList.add(entry);
                }
            }
        }

        System.debug('rcCountCache_StoreCDCForDate > cdcList: ' + cdcList);
        if (cdcList.size() > 0) {
            // store cdc counts
            insert cdcList;

            // clear cache entries
            for (rcCDC_Count__c entry : cdcList) {
                rcCountCache.removeCount(entry.Name);
            }
        }

    }

    private static String getDateString(Date cacheDate) {
        Datetime dt = DateTime.newInstance(cacheDate.year(), cacheDate.month(), cacheDate.day());
        return dt.format('ddMMyyyy');
    }

}