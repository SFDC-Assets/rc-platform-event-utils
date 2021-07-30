public with sharing class rcCountCache {

    private static String CACHE_PARTITION = 'local.CDC';
    private static Integer CACHE_TTL = 172800; // cache time-to-live in seconds = 48 hours, the max allowed
    private static Cache.OrgPartition orgCache;

    static {
        orgCache = Cache.Org.getPartition(CACHE_PARTITION);
        if (orgCache == null) {
            System.debug('rcCountCache > cache partition ' + CACHE_PARTITION + ' not configured');
        } else {
            System.debug('rcCountCache > cache partition ' + CACHE_PARTITION + ' found');
        }
    }

    public static void putUpdate(String objectName, Integer updateCount) {

        String key = today() + objectName;
        if (updateCount == null) updateCount = 1;
        System.debug('rcCountCache > putUpdate - ' + key + ', updateCount: ' + updateCount);

        if (orgCache != null) {
            try {
                // increment count
                Integer count = getCount(key) + updateCount;
                // update cache
                orgCache.put(key, count, CACHE_TTL);
                System.debug('rcCountCache > putUpdate - ' + key + ', count: ' + count + ' stored' );
            } catch (Exception e) {
                // problem storing the cache entry - e.g. size of entry > 100KB
                System.debug('rcCountCache > putUpdate - ' + key + ' exception: ' + e);
            }
        }
    }

    public static Integer getCount(String key) {

        Integer count = 0;
        if (orgCache != null) {
            Integer cnt = (Integer) orgCache.get(key);

            if (cnt == null) {
                System.debug('rcCountCache > getCount - ' + key + ' not found');
            } else {
                count = cnt;
                System.debug('rcCountCache > getCount - ' + key + ' found, count: ' + cnt);
            }
        }
        return count;
    }

    private static String today() {
        Date today = System.today();
        Datetime dt = DateTime.newInstance(today.year(), today.month(), today.day());
        return dt.format('ddMMyyyy');
    }

    public static Map<String, Integer> getCounts() {
        Map<String, Integer> countMap = new Map<String, Integer>();
        if (orgCache != null) {
            Set<String> keys = orgCache.getKeys();
            System.debug('rcCountCache > getCounts - keys: ' + keys);
            for (String key : keys) {
                countMap.put(key, (Integer) orgCache.get(key));
            }
        }
        return countMap;
    }

    public static void removeCount(String key) {
        System.debug('rcCountCache > removeCount - key: ' + key);
        if (orgCache != null) {
            orgCache.remove(key);
        }
    }

}