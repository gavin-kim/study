package dependencyinjection;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class KnightConfig {

    @Bean(name = "k")
    public Knight knight() {
        return new Knight(quest());
    }

    public Quest quest() {
        return new SlayDragonQuest(System.out);
    }
}


