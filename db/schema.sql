CREATE TYPE order_status AS ENUM ('pending', 'success', 'failed');

CREATE TYPE type_of_reward AS ENUM ('type1', 'type2', 'type3');

CREATE TABLE if not exists reward_payout (
    id BIGSERIAL not null,
    order_id uuid not null default public.uuid_generate_v4(),
    status_of_order order_status,
    CONSTRAINT fk_sc
        FOREIGN KEY (sc_id) 
        REFERENCES user_scratchcards (sc_id) 
        on delete cascade,
    reward type_of_reward,
    PRIMARY KEY (order_id)
);


CREATE TYPE sc_status AS ENUM ('claimed', 'available');

CREATE TABLE user_scratchcards (
    id BIGSERIAL not null,
    sc_id uuid not null default public.uuid_generate_v4(),
    user_id VARCHAR(20) not null,
    status sc_status,
    PRIMARY KEY (sc_id)
);