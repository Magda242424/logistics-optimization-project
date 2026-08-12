--
-- PostgreSQL database dump
--

\restrict iIWGDPgZPi8qgWrdaWeXJ4PGgLS1O5zyDkka8im5x59d7r5KkbMVLkkynT4mRgm

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-08-09 23:05:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16388)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    latitude numeric(8,4) NOT NULL,
    longitude numeric(9,4) NOT NULL,
    CONSTRAINT chk_city_latitude CHECK (((latitude >= ('-90'::integer)::numeric) AND (latitude <= (90)::numeric))),
    CONSTRAINT chk_city_longitude CHECK (((longitude >= ('-180'::integer)::numeric) AND (longitude <= (180)::numeric)))
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16400)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    client_id character varying(20) NOT NULL,
    city_id integer NOT NULL,
    segment character varying(30) NOT NULL,
    annual_demand_tons numeric(12,2) NOT NULL,
    priority integer NOT NULL,
    CONSTRAINT chk_client_demand CHECK ((annual_demand_tons >= (0)::numeric)),
    CONSTRAINT chk_client_priority CHECK ((priority >= 1))
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16417)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id character varying(20) NOT NULL,
    product_type character varying(100) NOT NULL,
    weight_kg numeric(10,2) NOT NULL,
    volume_m3 numeric(10,3) NOT NULL,
    transport_class character varying(50) NOT NULL,
    unit_value_eur numeric(12,2) NOT NULL,
    temperature_controlled boolean DEFAULT false NOT NULL,
    CONSTRAINT chk_product_value CHECK ((unit_value_eur >= (0)::numeric)),
    CONSTRAINT chk_product_volume CHECK ((volume_m3 > (0)::numeric)),
    CONSTRAINT chk_product_weight CHECK ((weight_kg > (0)::numeric))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16448)
-- Name: shipments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipments (
    shipment_id character varying(20) NOT NULL,
    client_id character varying(20) NOT NULL,
    product_id character varying(20) NOT NULL,
    warehouse_id character varying(20) NOT NULL,
    quantity integer NOT NULL,
    transport_mode character varying(30) NOT NULL,
    shipment_date date NOT NULL,
    destination_city_id integer NOT NULL,
    segment character varying(30) NOT NULL,
    priority integer NOT NULL,
    product_type character varying(100) NOT NULL,
    weight_kg numeric(10,2) NOT NULL,
    volume_m3 numeric(10,3) NOT NULL,
    unit_value_eur numeric(12,2) NOT NULL,
    total_weight_kg numeric(12,2) NOT NULL,
    total_volume_m3 numeric(12,3) NOT NULL,
    origin_city_id integer NOT NULL,
    origin_latitude numeric(8,4) NOT NULL,
    origin_longitude numeric(9,4) NOT NULL,
    destination_latitude numeric(8,4) NOT NULL,
    destination_longitude numeric(9,4) NOT NULL,
    distance_km numeric(12,2) NOT NULL,
    cost_per_ton_km numeric(10,4) NOT NULL,
    transport_cost_eur numeric(14,2) NOT NULL,
    average_speed_kmh numeric(8,2) NOT NULL,
    transit_time_hours numeric(10,2) NOT NULL,
    co2_kg numeric(14,2) NOT NULL,
    CONSTRAINT chk_shipment_co2 CHECK ((co2_kg >= (0)::numeric)),
    CONSTRAINT chk_shipment_cost CHECK ((transport_cost_eur >= (0)::numeric)),
    CONSTRAINT chk_shipment_distance CHECK ((distance_km >= (0)::numeric)),
    CONSTRAINT chk_shipment_quantity CHECK ((quantity > 0)),
    CONSTRAINT chk_shipment_speed CHECK ((average_speed_kmh > (0)::numeric)),
    CONSTRAINT chk_shipment_total_volume CHECK ((total_volume_m3 > (0)::numeric)),
    CONSTRAINT chk_shipment_total_weight CHECK ((total_weight_kg > (0)::numeric)),
    CONSTRAINT chk_shipment_transit CHECK ((transit_time_hours >= (0)::numeric)),
    CONSTRAINT chk_shipment_volume CHECK ((volume_m3 > (0)::numeric)),
    CONSTRAINT chk_shipment_weight CHECK ((weight_kg > (0)::numeric))
);


ALTER TABLE public.shipments OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16433)
-- Name: warehouses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouses (
    warehouse_id character varying(20) NOT NULL,
    city_id integer NOT NULL,
    capacity_tons numeric(12,2) NOT NULL,
    warehouse_type character varying(50) NOT NULL,
    CONSTRAINT chk_warehouse_capacity CHECK ((capacity_tons > (0)::numeric))
);


ALTER TABLE public.warehouses OWNER TO postgres;

--
-- TOC entry 4891 (class 2606 OID 16399)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- TOC entry 4893 (class 2606 OID 16411)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);


--
-- TOC entry 4897 (class 2606 OID 16432)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4909 (class 2606 OID 16489)
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (shipment_id);


--
-- TOC entry 4900 (class 2606 OID 16442)
-- Name: warehouses warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);


--
-- TOC entry 4894 (class 1259 OID 16515)
-- Name: idx_clients_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clients_city ON public.clients USING btree (city_id);


--
-- TOC entry 4895 (class 1259 OID 16516)
-- Name: idx_clients_segment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clients_segment ON public.clients USING btree (segment);


--
-- TOC entry 4901 (class 1259 OID 16518)
-- Name: idx_shipments_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipments_client ON public.shipments USING btree (client_id);


--
-- TOC entry 4902 (class 1259 OID 16523)
-- Name: idx_shipments_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipments_date ON public.shipments USING btree (shipment_date);


--
-- TOC entry 4903 (class 1259 OID 16522)
-- Name: idx_shipments_destination; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipments_destination ON public.shipments USING btree (destination_city_id);


--
-- TOC entry 4904 (class 1259 OID 16521)
-- Name: idx_shipments_origin; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipments_origin ON public.shipments USING btree (origin_city_id);


--
-- TOC entry 4905 (class 1259 OID 16519)
-- Name: idx_shipments_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipments_product ON public.shipments USING btree (product_id);


--
-- TOC entry 4906 (class 1259 OID 16524)
-- Name: idx_shipments_transport_mode; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipments_transport_mode ON public.shipments USING btree (transport_mode);


--
-- TOC entry 4907 (class 1259 OID 16520)
-- Name: idx_shipments_warehouse; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipments_warehouse ON public.shipments USING btree (warehouse_id);


--
-- TOC entry 4898 (class 1259 OID 16517)
-- Name: idx_warehouses_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_warehouses_city ON public.warehouses USING btree (city_id);


--
-- TOC entry 4910 (class 2606 OID 16412)
-- Name: clients fk_client_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT fk_client_city FOREIGN KEY (city_id) REFERENCES public.cities(city_id);


--
-- TOC entry 4912 (class 2606 OID 16490)
-- Name: shipments fk_shipment_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fk_shipment_client FOREIGN KEY (client_id) REFERENCES public.clients(client_id);


--
-- TOC entry 4913 (class 2606 OID 16510)
-- Name: shipments fk_shipment_destination_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fk_shipment_destination_city FOREIGN KEY (destination_city_id) REFERENCES public.cities(city_id);


--
-- TOC entry 4914 (class 2606 OID 16505)
-- Name: shipments fk_shipment_origin_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fk_shipment_origin_city FOREIGN KEY (origin_city_id) REFERENCES public.cities(city_id);


--
-- TOC entry 4915 (class 2606 OID 16495)
-- Name: shipments fk_shipment_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fk_shipment_product FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 4916 (class 2606 OID 16500)
-- Name: shipments fk_shipment_warehouse; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fk_shipment_warehouse FOREIGN KEY (warehouse_id) REFERENCES public.warehouses(warehouse_id);


--
-- TOC entry 4911 (class 2606 OID 16443)
-- Name: warehouses fk_warehouse_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouses
    ADD CONSTRAINT fk_warehouse_city FOREIGN KEY (city_id) REFERENCES public.cities(city_id);


-- Completed on 2026-08-09 23:05:02

--
-- PostgreSQL database dump complete
--

\unrestrict iIWGDPgZPi8qgWrdaWeXJ4PGgLS1O5zyDkka8im5x59d7r5KkbMVLkkynT4mRgm

