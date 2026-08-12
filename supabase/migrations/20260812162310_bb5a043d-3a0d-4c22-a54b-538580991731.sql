DO $$
DECLARE
    func_record RECORD;
BEGIN
    FOR func_record IN 
        SELECT proname, pg_get_function_arguments(oid) as args
        FROM pg_proc 
        WHERE pronamespace = 'public'::regnamespace
    LOOP
        EXECUTE format('ALTER FUNCTION public.%I(%s) SET search_path = public, pg_temp;', func_record.proname, func_record.args);
    END LOOP;
END $$;