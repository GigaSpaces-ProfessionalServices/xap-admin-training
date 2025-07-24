package security;

import com.gigaspaces.client.WriteModifiers;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.SpaceProxyConfigurer;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.annotation.Bean;

public class MyFeeder implements InitializingBean {

    @Bean
    public GigaSpace gigaSpaceProxy() {
        SpaceProxyConfigurer urlSpaceConfigurer = new SpaceProxyConfigurer("demo")
                .credentials("gs-admin","gs-admin");

        return new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
    }

    public void afterPropertiesSet() throws Exception {
            System.out.printf("MyFeeder is up" + "\n");
        Data[] objs = new Data[10];

        for( int i=0; i < 10; i++ ) {
            objs[i] = new Data((long) i, Integer.toString(i));
        }

        long leaseExpiry = 300000L;
        long timeout = 5000L;
        gigaSpaceProxy().writeMultiple(objs, leaseExpiry, timeout, WriteModifiers.UPDATE_OR_WRITE);
    }
}
